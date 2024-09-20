import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'color_field_state.dart';

class ColorFieldCubit extends Cubit<ColorFieldState> {
  ColorFieldCubit() : super(const ColorFieldInitial(Colors.grey));

  void setSelectedColor(Color color) {
    emit(ColorFieldSelected(color));
  }
}
