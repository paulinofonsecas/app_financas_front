import 'package:app_financas/presentation/components/movimento_item.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/movimentos_screen_controller.dart';
import '../cubit/home_page_cubit.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final MovimentoScreenController controller;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final PagingController<int, Movimento> pagingController;
  late final HomePageCubit homePageCubit;

  var page = 1;

  @override
  void initState() {
    homePageCubit = getIt();
    pagingController = PagingController(firstPageKey: 1);

    pagingController.addPageRequestListener((pageKey) {
      homePageCubit.getPaginatedMovimentos(pageKey);
    });

    homePageCubit.getPaginatedMovimentos(page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: BlocConsumer<HomePageCubit, HomePageState>(
          bloc: homePageCubit,
          listener: (BuildContext context, HomePageState state) {
            if (state is HomePageGetPaginatedListSuccess) {
              pagingController.appendPage(state.movimentos, state.nextPageKey);
            }

            if (state is HomePageGetLastPaginatedListSuccess) {
              pagingController.appendLastPage(state.movimentos);
            }
          },
          buildWhen: (previous, current) {
            return current is HomePageGetLastPaginatedListSuccess ||
                current is HomePageGetPaginatedListSuccess;
          },
          builder: (context, state) {
            if (state is HomePageLoadingMovimentosState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomePageGetPaginatedListError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            if (state is HomePageGetPaginatedListSuccess ||
                state is HomePageGetLastPaginatedListSuccess) {
              return PagedListView<int, Movimento>(
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movimento>(
                  itemBuilder: (context, movimento, index) =>
                      _buildMovimentoItem(movimento, context),
                ),
              );
            }

            return const Center(
              child: Text('Sem dados para apresentar'),
            );
          },
        ),
      ),
    );
  }

  MovimentoItem _buildMovimentoItem(Movimento movimento, BuildContext context) {
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
              widget.controller.update(['geral']);
              pagingController.refresh();
            },
          ),
        );
      },
    );
  }
}
