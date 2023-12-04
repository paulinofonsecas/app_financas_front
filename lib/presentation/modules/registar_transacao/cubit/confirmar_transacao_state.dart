part of 'confirmar_transacao_cubit.dart';

sealed class ConfirmarTransacaoState extends Equatable {
  const ConfirmarTransacaoState(this.isTransacaoConfirmad);

  final bool isTransacaoConfirmad;

  @override
  List<Object> get props => [isTransacaoConfirmad];
}

final class ConfirmarTransacaoInitial extends ConfirmarTransacaoState {
  const ConfirmarTransacaoInitial(super.isTransacaoConfirmad);
}

final class ConfirmarTransacaoChanged extends ConfirmarTransacaoState {
  const ConfirmarTransacaoChanged(super.isTransacaoConfirmad);
}
