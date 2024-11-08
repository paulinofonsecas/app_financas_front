// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/score/domain/entitys/item_planejamento.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ItemPlanejamentoPieChart extends StatelessWidget {
  const ItemPlanejamentoPieChart({
    super.key,
    required this.itemPlanejamentos,
  });

  final List<ItemPlanejamento> itemPlanejamentos;

  List<Color> generateUnrepeatedColors() {
    return [...Colors.primaries]..take(itemPlanejamentos.length);
  }

  @override
  Widget build(BuildContext context) {
    final colors = generateUnrepeatedColors();

    return PieChart(
      PieChartData(
        sections: itemPlanejamentos
            .map(
              (e) => PieChartSectionData(
                color: e.id == 80808080
                    ? Colors.grey
                    : colors[itemPlanejamentos.indexOf(e)],
                value: e.plafound,
                title: e.categoria.name,
                radius: 70,
                titleStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
        centerSpaceRadius: 60,
        sectionsSpace: 2,
      ),
    );
  }
}
