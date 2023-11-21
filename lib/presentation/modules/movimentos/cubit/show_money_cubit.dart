// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_money_state.dart';

class ShowMoneyCubit extends Cubit<ShowMoneyState> {
  ShowMoneyCubit() : super(const ShowMoneyChangeValue(false));

  void changeValue() {
    emit(ShowMoneyChangeValue(!state.value));
  }
}
