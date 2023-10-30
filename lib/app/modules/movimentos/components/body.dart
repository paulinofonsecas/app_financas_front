import 'package:app_financas/app/components/movimento_item.dart';
import 'package:app_financas/app/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/movimentos_screen_controller.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final MovimentoScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: GetBuilder(
          init: controller,
          id: 'movimento_screen',
          builder: (context) {
            return PagedListView<int, Movimento>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Movimento>(
                itemBuilder: (context, movimento, index) => MovimentoItem(
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
                          controller.update(['geral']);
                          controller.pagingController.refresh();
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
