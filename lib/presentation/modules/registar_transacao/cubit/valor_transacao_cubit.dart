import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'valor_transacao_state.dart';

class ValorTransacaoCubit extends Cubit<ValorTransacaoState> {
  ValorTransacaoCubit() : super(const ValorTransacaoInicial(''));

  void changeValorTransacao(String valor) {
    emit(ValorTransacaoChanged(valor));
  }
}
