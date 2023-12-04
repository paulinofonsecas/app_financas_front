import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_transacao_state.dart';

class SwitchTransacaoCubit extends Cubit<SwitchTransacaoState> {
  SwitchTransacaoCubit() : super(SwitchTransacaoEntrada());

  void defineTransationType(int movimentoType) {
    if (movimentoType == 1) {
      emit(SwitchTransacaoEntrada());
    } else {
      emit(SwitchTransacaoSaida());
    }
  }

  void switchTransationType() {
    if (state is SwitchTransacaoEntrada) {
      emit(SwitchTransacaoSaida());
    } else {
      emit(SwitchTransacaoEntrada());
    }
  }
}
