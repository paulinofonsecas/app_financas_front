part of 'registar_transacao_bloc.dart';

sealed class RegistarTransacaoEvent extends Equatable {
  const RegistarTransacaoEvent();

  @override
  List<Object> get props => [];
}

class SalvarTransacaoEvent extends RegistarTransacaoEvent {
  const SalvarTransacaoEvent(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [context];
}
