part of 'registar_transacao_bloc.dart';

sealed class RegistarTransacaoEvent extends Equatable {
  const RegistarTransacaoEvent();

  @override
  List<Object> get props => [];
}

class SaveTransacaoEvent extends RegistarTransacaoEvent {}