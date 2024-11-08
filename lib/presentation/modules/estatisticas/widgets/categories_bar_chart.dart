import 'package:app_financas/presentation/modules/estatisticas/controller/estatisticas_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_item_pie_chart.dart';

class CategoriesPieChart extends StatelessWidget {
  const CategoriesPieChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EstatisticasPageController>();

    return GetBuilder(
      init: controller,
      id: 'chartCategorias',
      builder: (context) {
        var categorias = controller.categorias;

        return Wrap(
          children: categorias.map((categoria) {
            return CategoryItemPieChart(categoria: categoria);
          }).toList(),
        );

        // return SizedBox(
        //   height: 40,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: categorias.length,
        //     separatorBuilder: (context, index) {
        //       return const VerticalDivider();
        //     },
        //     itemBuilder: (context, index) {
        //       var categoria = categorias[index];
        //       return CategoryItemPieChart(categoria: categoria);
        //     },
        //   ),
        // );
      },
    );
  }
}
