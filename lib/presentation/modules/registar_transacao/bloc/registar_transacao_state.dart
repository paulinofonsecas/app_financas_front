part of 'registar_transacao_bloc.dart';

sealed class RegistarTransacaoState extends Equatable {
  const RegistarTransacaoState();
  
  @override
  List<Object> get props => [];
}

final class RegistarTransacaoInitial extends RegistarTransacaoState {}
