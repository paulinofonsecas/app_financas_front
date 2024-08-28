// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeChanged(ThemeMode.system));

  void changeThemeMode(ThemeMode themeMode) {
    emit(AppThemeChanged(themeMode));
  }

  void toggleTheme() {
    var themeMode = state.themeMode;

    var themeTarget =
        themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    emit(AppThemeChanged(themeTarget));
  }
}
