part of 'conta_bloc.dart';

sealed class ContaEvent extends Equatable {
  const ContaEvent();

  @override
  List<Object> get props => [];
}

class ListarContasEvent extends ContaEvent {}

class CalcularSaldoMensalEvent extends ContaEvent {
  final int mes;

  const CalcularSaldoMensalEvent(this.mes);

  @override
  List<Object> get props => [mes];
}