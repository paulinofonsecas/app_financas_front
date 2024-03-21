part of 'conta_bloc.dart';

sealed class GContaState extends Equatable {
  const GContaState();

  @override
  List<Object> get props => [];
}

final class ContaInitial extends GContaState {}

final class ArquivarContaSuccess extends GContaState {}

final class DesarquivarContaSucess extends GContaState {}

// contas

final class ListarContasLoading extends GContaState {}

final class ListarContasSuccess extends GContaState {
  final List<Conta> contas;

  const ListarContasSuccess(this.contas);

  @override
  List<Object> get props => [contas];
}

final class ListarContasError extends GContaState {
  final String? errorMessage;

  const ListarContasError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class ListarContasEmpty extends GContaState {}

// end listar contas

// calcular saldo mensal
final class CalcularSaldoMensalLoading extends GContaState {}

final class CalcularSaldoMensalError extends GContaState {}

final class CalcularSaldoMensalSuccess extends GContaState {
  final BalancoMensal balanco;

  const CalcularSaldoMensalSuccess(this.balanco);

  @override
  List<Object> get props => [balanco];
}

final class CalcularSaldoMensalEmpty extends GContaState {}
// end calcular saldo mensal

// change mostrar saldo na tela incial

final class ChangeViewSaldoInHomePageState extends GContaState {}

final class ChangeViewSaldoInHomePageSuccess extends ChangeViewSaldoInHomePageState {}

final class ChangeViewSaldoInHomePageError extends ChangeViewSaldoInHomePageState {}
