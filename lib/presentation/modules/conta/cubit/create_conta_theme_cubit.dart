import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_conta_theme_state.dart';

class CreateContaThemeCubit extends Cubit<CreateContaThemeState> {
  CreateContaThemeCubit() : super(const CreateContaThemeInitial(Colors.blue));

  void changeColor(Color color) {
    emit(CreateContaThemeChanged(color));
  }
}
