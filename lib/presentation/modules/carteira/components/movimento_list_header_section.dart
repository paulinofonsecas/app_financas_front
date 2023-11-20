import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'my_text_filter.dart';

class HeaderMovimentoSection extends StatelessWidget {
  const HeaderMovimentoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var carteiraController = Get.find<CarteiraPageController>();

    return Hero(
      tag: 'header_movimento',
      child: Material(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            MyTextFilter(
              title: 'Tudo',
              isActive: carteiraController.esFilter == 0,
              onTap: () {
                carteiraController.changeESFilter(0);
              },
            ),
            const GutterTiny(),
            MyTextFilter(
              title: 'Saídas',
              isActive: carteiraController.esFilter == TipoMovimento.SAIDA,
              onTap: () {
                carteiraController.changeESFilter(TipoMovimento.SAIDA);
              },
            ),
            const GutterTiny(),
            MyTextFilter(
              title: 'Entrada',
              isActive: carteiraController.esFilter == TipoMovimento.ENTRADA,
              onTap: () {
                carteiraController.changeESFilter(TipoMovimento.ENTRADA);
              },
            ),
          ],
        ),
      ),
    );
  }
}
