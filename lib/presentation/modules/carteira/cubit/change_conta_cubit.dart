// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_conta_state.dart';

class ChangeContaCubit extends Cubit<ChangeContaState> {
  ChangeContaCubit() : super(ChageContaInitial());

  void updateContaIndex(int id) {
    emit(ContasUpdateContaIndex(id));
  }
}
