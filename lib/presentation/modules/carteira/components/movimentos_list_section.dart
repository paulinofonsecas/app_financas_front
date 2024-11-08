import 'package:app_financas/presentation/components/movimento_item.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_conta_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_tipo_movimento_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/movimentos_by_conta_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'movimento_list_header_section.dart';

class MovimentosListSection extends StatefulWidget {
  const MovimentosListSection({
    super.key,
  });

  @override
  State<MovimentosListSection> createState() => _MovimentosListSectionState();
}

class _MovimentosListSectionState extends State<MovimentosListSection> {
  late final PagingController<int, Movimento> pagingController;
  late final MovimentosByContaCubit movimentosCubit;
  var contaId = 0;
  var page = 1;

  @override
  void initState() {
    movimentosCubit = getIt();
    pagingController = PagingController(firstPageKey: 1);

    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 1) {
        return;
      }
      var tipoMovimentoState = context.read<ChangeTipoMovimentoCubit>().state;

      movimentosCubit.getMovimentosByConta(
        pageKey,
        contaId,
        tipoMovimentoState.index,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var carteiraController = Get.find<CarteiraPageController>();

    return MultiBlocListener(
      listeners: [
        BlocListener<ChangeContaCubit, ChangeContaState>(
          listener: (context, state) {
            if (state is ContasUpdateContaIndex) {
              setState(() {
                contaId = state.index;

                var tipoMovimentoState =
                    context.read<ChangeTipoMovimentoCubit>().state;
                page = 1;
                pagingController.refresh();
                movimentosCubit.getMovimentosByConta(
                  1,
                  contaId,
                  tipoMovimentoState.index,
                );
              });
            }
          },
        ),
        BlocListener<ChangeTipoMovimentoCubit, ChangeTipoMovimentoState>(
          listener: (context, state) {
            if (state is ChangeTipoMovimentoChanged) {
              setState(() {
                page = 1;
                pagingController.refresh();
                movimentosCubit.getMovimentosByConta(
                    page, contaId, state.index);
              });
            }
          },
        ),
        BlocListener<ReajustarSaldoCubit, ReajustarSaldoState>(
          listener: (context, state) {
            if (state is ReajustarSaldoSuccess) {
              setState(() {
                page = 1;
                pagingController.refresh();
                movimentosCubit.getMovimentosByConta(
                  1,
                  contaId,
                  0,
                );
              });
            }
          },
        )
      ],
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderMovimentoSection(),
              const GutterTiny(),
              BlocConsumer<MovimentosByContaCubit, MovimentosByContaState>(
                listener: (context, state) {
                  if (state is MovimentosByContaSuccess) {
                    pagingController.appendPage(
                        state.movimentos, state.nextPageKey);
                  }

                  if (state is MovimentosByContaLastSuccess) {
                    pagingController.appendLastPage(state.movimentos);
                  }
                },
                builder: (context, state) {
                  if (state is MovimentosByContaLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MovimentosByContaError) {
                    return Text('//${state.errorMessage}');
                  }

                  if (state is MovimentosByContaEmpty) {
                    return const Text('Sem movimentos para apresentar');
                  }

                  if (state is MovimentosByContaSuccess ||
                      state is MovimentosByContaLastSuccess) {
                    return Expanded(
                      child: PagedListView<int, Movimento>(
                        pagingController: pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Movimento>(
                          itemBuilder: (context, movimento, index) =>
                              _buildMovimentoItem(
                            movimento,
                            context,
                            carteiraController,
                          ),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  MovimentoItem _buildMovimentoItem(Movimento movimento, BuildContext context,
      CarteiraPageController carteiraController) {
    return MovimentoItem(
      movimento: movimento,
      asset: 'assets/svgs/categories/desktop.svg',
      title: movimento.descricao,
      conta: 'Tecnologia',
      valor: movimento.valor,
      tipoMovimentoId: movimento.tipoMovimentoId,
      avatarBgColor: kAmarelhoColor,
      onTap: () {
        if (movimento.categoriaMovimentoId == 303030) return;
        if (movimento.categoriaMovimentoId == 303040) return;
        customShowModalBottomSheet(
          context,
          child: ShowTransactionPage(
            movimento: movimento,
            onEdit: () {
              carteiraController.update(['geral']);
              carteiraController.pagingController.refresh();
            },
            onConfirmar: () {
              carteiraController.pagingController.refresh();
              carteiraController.update(['geral']);
            },
          ),
        );
      },
    );
  }
}
