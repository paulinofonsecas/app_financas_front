import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'change_theme_color_state.dart';

class ChangeThemeColorCubit extends Cubit<ChangeThemeColorState> {
  ChangeThemeColorCubit(Color color) : super(ChangeThemeColorInitial(color));

  void changeThemeColor(Color color) async {
    final Box<int> box = await Hive.openBox('theme_color');
    await box.put('color', color.value);

    emit(ChangeThemeColorSuccess(color));
  }

  void loadDefaultThemeColor() async {
    final Box<int> box = await Hive.openBox('theme_color');
    final color = Color(box.get('color', defaultValue: Colors.green.value)!);

    emit(ChangeThemeColorSuccess(color));
  }
}
