// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/estatisticas_page_controller.dart';
import 'utils/get_chart_title_mixin.dart';

class EstatisticaDeLinhaComFiltros extends StatelessWidget {
  const EstatisticaDeLinhaComFiltros({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EstatisticasPageController>();

    return GetBuilder(
        init: controller,
        id: 'geral',
        builder: (context) {
          return FutureBuilder<List<FlSpot>?>(
              future: controller.getMovimentosSpots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.error != null) {
                  return Text('${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(''),
                  );
                }

                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var spots = snapshot.data ?? [];

                return LineChartSample2(
                  spots: spots,
                );
              });
        });
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({
    Key? key,
    required this.spots,
  }) : super(key: key);

  final List<FlSpot> spots;

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2>
    with EstatisticaLineSemanaHelper {
  late final EstatisticasPageController controller;

  @override
  void initState() {
    controller = Get.put(EstatisticasPageController());
    super.initState();
  }

  List<Color> entradaGradientColors = [
    Colors.blueAccent,
    Colors.greenAccent,
  ];

  List<Color> saidaGradientColors = [
    const Color.fromARGB(255, 240, 105, 109),
    const Color.fromARGB(255, 255, 68, 68),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        LineChartData(
          minY: 0,
          minX: calculeMinX(controller),
          maxX: calculeMaxX(controller),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: calculateXInterval(controller),
                getTitlesWidget: (value, meta) {
                  return bottomTitleWidgets(value, meta, controller);
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(
                color: Colors.black,
              ),
              left: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            checkToShowHorizontalLine: (value) => true,
            checkToShowVerticalLine: (value) => true,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: widget.spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: controller.esFilter == 1
                    ? entradaGradientColors
                    : saidaGradientColors,
              ),
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (
                  FlSpot spot,
                  double xPercentage,
                  LineChartBarData bar,
                  int index,
                ) {
                  return FlDotCirclePainter(
                    color: Colors.purpleAccent,
                    strokeColor: Colors.transparent,
                    radius: 5,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: (controller.esFilter == 1
                          ? entradaGradientColors
                          : saidaGradientColors)
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
