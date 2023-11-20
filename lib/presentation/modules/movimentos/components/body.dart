import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/components/movimento_item.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/movimentos_screen_controller.dart';

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
  late final MovimentoBloc movimentoBloc;

  var page = 1;
  var pageSize = 10;

  @override
  void initState() {
    movimentoBloc = locator();
    pagingController = PagingController(firstPageKey: 1);

    pagingController.addPageRequestListener((pageKey) {
      movimentoBloc.add(
        MovimentoGetPaginatedListEvent(
          pageKey,
          pageSize,
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: BlocConsumer<MovimentoBloc, MovimentoState>(
          bloc: movimentoBloc
            ..add(MovimentoGetPaginatedListEvent(page, pageSize)),
          listener: (BuildContext context, MovimentoState state) {
            if (state is MovimentoGetPaginatedListSuccess) {
              pagingController.appendPage(state.movimentos, state.nextPageKey);
            }

            if (state is MovimentoGetLastPaginatedListSuccess) {
              pagingController.appendLastPage(state.movimentos);
            }
          },
          builder: (context, state) {
            if (state is MovimentoGetPaginatedListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MovimentoGetPaginatedListError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            if (state is MovimentoGetPaginatedListSuccess ||
                state is MovimentoGetLastPaginatedListSuccess) {
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
