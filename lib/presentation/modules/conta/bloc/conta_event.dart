part of 'conta_bloc.dart';

sealed class ContaEvent extends Equatable {
  const ContaEvent();

  @override
  List<Object> get props => [];
}

class ListarContasEvent extends ContaEvent {}

class ListarContasAtEvent extends ContaEvent {
  final int mes;

  const ListarContasAtEvent(this.mes);

  @override
  List<Object> get props => [mes];
}

class CalcularSaldoMensalEvent extends ContaEvent {
  final int mes;

  const CalcularSaldoMensalEvent(this.mes);

  @override
  List<Object> get props => [mes];
}

class ChangeViewSaldoInHomePage extends ContaEvent {
  final Conta conta;

  const ChangeViewSaldoInHomePage(this.conta);

  @override
  List<Object> get props => [conta];
}
