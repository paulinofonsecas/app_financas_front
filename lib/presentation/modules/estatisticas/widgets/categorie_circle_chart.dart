import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/components/empty_widget.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/estatisticas_page_controller.dart';

class BuildCategoriesPieChart extends StatelessWidget {
  const BuildCategoriesPieChart({
    super.key,
    this.data,
  });

  final List<PieChartSectionData>? data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EstatisticasPageController>();

    return data!.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              headerSection(),
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
          )
        : const EmptyWidget(
            title: 'Sem dados para apresentar',
          );
  }

  Widget headerSection() {
    var controller = Get.find<EstatisticasPageController>();

    return Text(
      '${controller.esFilter == 1 ? 'Receitas' : 'Despesas'} por categoria',
      style: GoogleFonts.inter(
        fontSize: Get.textTheme.titleLarge!.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
