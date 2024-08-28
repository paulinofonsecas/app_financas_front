import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isReceita(int movimentoType) => movimentoType == 1;

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

void showErrorMessage(String title, String message,
    {Duration? duration, Color? backgroundColor}) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      duration: duration ?? const Duration(seconds: 4),
      backgroundColor: backgroundColor ?? Colors.red,
      isDismissible: true,
      borderRadius: 10,
    ),
  );
}

void showSucessMessage(String title, String message) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      isDismissible: true,
      borderRadius: 10,
    ),
  );
}

List<Color> get randomColors {
  List<Color> myColors = List.from(Colors.primaries);
  myColors.shuffle();
  return myColors;
}

String getMonthName(int mes) {
  switch (mes) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
    default:
      return 'Erro';
  }
}

String getSortMonthName(int mes) {
  switch (mes) {
    case 1:
      return 'JAN';
    case 2:
      return 'FEV';
    case 3:
      return 'MAR';
    case 4:
      return 'ABR';
    case 5:
      return 'MAI';
    case 6:
      return 'JUN';
    case 7:
      return 'JUL';
    case 8:
      return 'AGO';
    case 9:
      return 'SET';
    case 10:
      return 'OUT';
    case 11:
      return 'NOV';
    case 12:
      return 'DEZ';
    default:
      return 'Erro';
  }
}

int lastDayOfWeek(int ano, int mes) {
  if (mes == 12) {
    return DateTime(ano + 1, 1, 0).day;
  }

  return DateTime(ano, mes + 1, 0).day;
}
