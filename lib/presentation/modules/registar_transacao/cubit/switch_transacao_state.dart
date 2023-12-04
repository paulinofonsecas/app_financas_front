part of 'switch_transacao_cubit.dart';

sealed class SwitchTransacaoState extends Equatable {
  const SwitchTransacaoState();

  @override
  List<Object> get props => [];
}

final class SwitchTransacaoEntrada extends SwitchTransacaoState {}

final class SwitchTransacaoSaida extends SwitchTransacaoState {}
