import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirmar_transacao_state.dart';

class ConfirmarTransacaoCubit extends Cubit<ConfirmarTransacaoState> {
  ConfirmarTransacaoCubit(bool? confirmado)
      : super(ConfirmarTransacaoChanged(confirmado ?? true));

  void changeConfirmarTransacao() {
    emit(ConfirmarTransacaoChanged(!state.isTransacaoConfirmad));
  }
}
