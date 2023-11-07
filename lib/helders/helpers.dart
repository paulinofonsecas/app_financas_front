import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isReceita(int movimentoType) => movimentoType == 1;

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

void showErrorMessage(String title, String message) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      isDismissible: true,
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
    ),
  );
}

List<Color> get randomColors {
    List<Color> myColors = List.from(Colors.primaries);
    myColors.shuffle();
    return myColors;
  }