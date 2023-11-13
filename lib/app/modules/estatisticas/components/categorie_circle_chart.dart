import 'package:app_financas/constants.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import '../controller/estatisticas_page_controller.dart';

class CategoriesCircleChart extends StatelessWidget {
  const CategoriesCircleChart({
    Key? key,
    this.data,
  }) : super(key: key);

  final List<PieChartSectionData>? data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EstatisticasPageController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 70,
              startDegreeOffset: 130,
              sections: data,
            ),
            swapAnimationDuration: const Duration(milliseconds: 300),
            swapAnimationCurve: Curves.fastEaseInToSlowEaseOut,
          ),
        ),
        const Gutter(),
        Column(
          children: [
            const SizedBox(height: kDefaultPadding),
            Text(
              controller.esFilter == 1
                  ? numberFormat.format(controller.totalEntradas)
                  : numberFormat.format(controller.totalSaidas),
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
