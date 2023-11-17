import 'package:app_financas/app/modules/estatisticas/controller/estatisticas_page_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

mixin EstatisticaLineSemanaHelper {
  Widget bottomTitleWidgets(
    double value,
    TitleMeta meta,
    EstatisticasPageController controller,
  ) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    Widget text;
    var periodoId = controller.periodoId;

    switch (periodoId) {
      case 0:
        text = Text(getHorasTitle(value), style: style);
        break;
      case 1:
        text = Text(getWeekTitle(value), style: style);
        break;
      case 2:
        text = Text(getDayTitle(value), style: style);
        break;
      case 3:
        text = Text(getMonthTitle(value), style: style);
        break;
      case 4:
        text = Text(getMonthTitle(value), style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  double calculeMaxX(
    EstatisticasPageController controller,
  ) {
    switch (controller.periodoId) {
      case 0:
        return 23;
      case 1:
        return 7;
      case 2:
        return 30;
      case 3:
        return 12;
      case 4:
        return 12;
      default:
        return 0;
    }
  }

  double calculeMinX(
    EstatisticasPageController controller,
  ) {
    switch (controller.periodoId) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 2:
        return 1;
      case 3:
        return DateTime.now().month <= 6 ? 1 : 7;
      case 4:
        return 1;
      default:
        return 1;
    }
  }

  double calculateXInterval(
    EstatisticasPageController controller,
  ) {
    switch (controller.periodoId) {
      case 0:
        return 5;
      case 1:
        return 1;
      case 2:
        return 5;
      case 3:
        return 1;
      case 4:
        return 1;
      default:
        return 0;
    }
  }

  String getHorasTitle(double value0) {
    var value = value0.round();
    if (value == 0) {
      return '0H';
    }

    if (value > 0 && value <= 5) {
      return '5H';
    }

    if (value > 5 && value <= 10) {
      return '10H';
    }

    if (value > 10 && value <= 15) {
      return '15H';
    }

    if (value > 15 && value <= 20) {
      return '20H';
    }

    if (value > 20 && value <= 23) {
      return '23H';
    }

    return 'Invalid';
  }

  String getDayTitle(double value) {
    switch (value.toInt()) {
      case 1:
        return '1';
      case 2:
        return '2';
      case 3:
        return '3';
      case 4:
        return '4';
      case 5:
        return '5';
      case 6:
        return '6';
      case 7:
        return '7';
      case 8:
        return '8';
      case 9:
        return '9';
      case 10:
        return '10';
      case 11:
        return '11';
      case 12:
        return '12';
      case 13:
        return '13';
      case 14:
        return '14';
      case 15:
        return '15';
      case 16:
        return '16';
      case 17:
        return '17';
      case 18:
        return '18';
      case 19:
        return '19';
      case 20:
        return '20';
      case 21:
        return '21';
      case 22:
        return '22';
      case 23:
        return '23';
      case 24:
        return '24';
      case 25:
        return '25';
      case 26:
        return '26';
      case 27:
        return '27';
      case 28:
        return '28';
      case 29:
        return '29';
      case 30:
        return '30';
      case 31:
        return '31';
      default:
        return 'Invalid day';
    }
  }

  String getWeekTitle(double value) {
    switch (value.toInt()) {
      case 1:
        return 'S';
      case 2:
        return 'T';
      case 3:
        return 'Q';
      case 4:
        return 'Q';
      case 5:
        return 'S';
      case 6:
        return 'S';
      case 7:
        return 'D';
      default:
        return '';
    }
  }

  String getMonthTitle(double month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid month';
    }
  }
}
