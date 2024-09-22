import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'valor_transacao_state.dart';

class ValorTransacaoCubit extends Cubit<ValorTransacaoState> {
  ValorTransacaoCubit(double? valor)
      : super(ValorTransacaoChanged(valor?.toString() ?? ''));

  void changeValorTransacao(String valor) {
    if (valor.isEmpty) {
      return;
    }
    emit(ValorTransacaoChanged(valor));
  }
}
