import 'package:app_financas/presentation/components/movimento_item.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'movimento_list_header_section.dart';

class MovimentosListSection extends StatelessWidget {
  const MovimentosListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var carteiraController = Get.find<CarteiraPageController>();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderMovimentoSection(),
            const GutterTiny(),
            Expanded(
              child: PagedListView<int, Movimento>(
                pagingController: carteiraController.pagingController,
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
