part of 'reajustar_saldo_cubit.dart';

sealed class ReajustarSaldoState extends Equatable {
  final double saldo;

  const ReajustarSaldoState(this.saldo);

  @override
  List<Object> get props => [saldo];
}

final class ReajustarSaldoInitial extends ReajustarSaldoState {
  const ReajustarSaldoInitial() : super(0);
}

final class SaldoChanged extends ReajustarSaldoState {
  const SaldoChanged(super.saldo);
}

final class SaldoChangedWithError extends ReajustarSaldoState {
  const SaldoChangedWithError() : super(0);
}

final class ReajustarSaldoLoading extends ReajustarSaldoState {
  const ReajustarSaldoLoading() : super(0);
}

final class ReajustarSaldoSuccess extends ReajustarSaldoState {
  const ReajustarSaldoSuccess() : super(0);
}

final class ReajustarSaldoError extends ReajustarSaldoState {
  const ReajustarSaldoError() : super(0);
}
