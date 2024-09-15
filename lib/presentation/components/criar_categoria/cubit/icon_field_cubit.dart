import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'icon_field_state.dart';

class IconFieldCubit extends Cubit<IconFieldState> {
  IconFieldCubit() : super(const IconFieldInitial(Icons.savings));

  void selectIcon(IconData icon) {
    emit(IconFieldSelected(icon));
  }

  void setSelectedIcon(IconData icon) {
    emit(IconFieldSelected(icon));
  }
}
