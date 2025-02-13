import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'change_theme_color_state.dart';

/// The `ChangeThemeColorCubit` is a Bloc/Cubit that manages the state of the
/// theme color in the application. It is responsible for changing the theme
/// color and persisting the new color to the Hive box.
class ChangeThemeColorCubit extends Cubit<ChangeThemeColorState> {
  ChangeThemeColorCubit(this.color) : super(ChangeThemeColorInitial(color));

  late final Color color;

  /// Changes the theme color and saves it to the Hive box.
  ///
  /// This method is responsible for updating the theme color and persisting the
  /// new color to the Hive box. It first opens the 'theme_color' box, then
  /// stores the new color value in the box. Finally, it emits a
  /// [ChangeThemeColorSuccess] event with the new color.
  ///
  /// @param color The new theme color to be set.
  void changeThemeColor(Color color) async {
    final Box<int> box = await Hive.openBox('theme_color');
    await box.put('color', color.value);

    emit(ChangeThemeColorSuccess(color));
  }

  void loadDefaultThemeColor() async {
    final Box<int> box = await Hive.openBox('theme_color');
    final newColor = Color(box.get('color', defaultValue: color.value)!);

    emit(ChangeThemeColorSuccess(newColor));
  }
}
