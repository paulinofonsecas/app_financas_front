import 'package:flutter/material.dart';

bool isReceita(int movimentoType) => movimentoType == 1;

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
