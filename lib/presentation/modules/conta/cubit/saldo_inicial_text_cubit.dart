import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'saldo_inicial_text_state.dart';

class SaldoInicialTextCubit extends Cubit<SaldoInicialTextState> {
  SaldoInicialTextCubit() : super(const SaldoInicialTextInitial(''));

  void onTextChange(String value) {
    emit(SaldoInicialTextChanged(value));
  }
}
