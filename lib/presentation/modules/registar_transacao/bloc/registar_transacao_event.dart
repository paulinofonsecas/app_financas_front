part of 'registar_transacao_bloc.dart';

sealed class RegistarTransacaoEvent extends Equatable {
  const RegistarTransacaoEvent();

  @override
  List<Object> get props => [];
}

class SalvarTransacaoEvent extends RegistarTransacaoEvent {
  const SalvarTransacaoEvent({required this.context, this.movimento});

  final BuildContext context;
  final Movimento? movimento;

  @override
  List<Object> get props => [context];
}
