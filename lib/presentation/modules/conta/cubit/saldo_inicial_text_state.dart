part of 'saldo_inicial_text_cubit.dart';

sealed class SaldoInicialTextState extends Equatable {
  const SaldoInicialTextState();

  @override
  List<Object> get props => [];
}

final class SaldoInicialTextInitial extends SaldoInicialTextState {
  final String saldo;

  const SaldoInicialTextInitial(this.saldo);

  @override
  List<Object> get props => [saldo];
}

final class SaldoInicialTextChanged extends SaldoInicialTextState {
  final String saldo;

  const SaldoInicialTextChanged(this.saldo);

  @override
  List<Object> get props => [saldo];
}
