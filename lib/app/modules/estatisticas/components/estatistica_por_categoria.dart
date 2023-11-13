// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/app/modules/carteira/components/my_text_filter.dart';
import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/constants.dart';

import '../controller/estatisticas_page_controller.dart';
import 'components/categorie_circle_chart.dart';
import 'components/categories_bar_chart.dart';

class EstatisticaPorCategoria extends StatelessWidget {
  const EstatisticaPorCategoria({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EstatisticasPageController>();

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: GetBuilder(
        init: controller,
        id: 'geral',
        builder: (context) {
          return Column(
            children: [
              _buildFilters(),
              const GutterLarge(),
              _buildCategoriaChartData(),
            ],
          );
        },
      ),
    );
  }

  FutureBuilder<List<PieChartSectionData>?> _buildCategoriaChartData() {
    var controller = Get.find<EstatisticasPageController>();
    return FutureBuilder<List<PieChartSectionData>?>(
      future: controller.getCategoriesChartData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.error != null) {
          return Text('${snapshot.error}');
        }

        var contas = snapshot.data ?? [];

        return Column(
          children: [
            CategoriesCircleChart(
              data: contas,
            ),
            const GutterLarge(),
            const CategoriesBarChart(),
          ],
        );
      },
    );
  }

  Widget _buildFilters() {
    var controller = Get.find<EstatisticasPageController>();

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GutterTiny(),
          MyTextFilter(
            title: 'Saídas',
            isActive: controller.esFilter == TipoMovimento.SAIDA,
            onTap: () {
              controller.changeESFilter(TipoMovimento.SAIDA);
            },
          ),
          const GutterTiny(),
          MyTextFilter(
            title: 'Entrada',
            isActive: controller.esFilter == TipoMovimento.ENTRADA,
            onTap: () {
              controller.changeESFilter(TipoMovimento.ENTRADA);
            },
          ),
        ],
      ),
    );
  }
}
