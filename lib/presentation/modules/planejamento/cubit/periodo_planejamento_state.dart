part of 'periodo_planejamento_cubit.dart';

sealed class PeriodoPlanejamentoState extends Equatable {
  const PeriodoPlanejamentoState(this.periodo);

  final DateTime periodo;

  @override
  List<Object> get props => [periodo];
}

final class PeriodoPlanejamentoInitial extends PeriodoPlanejamentoState {
  const PeriodoPlanejamentoInitial(super.periodo);
}

final class PeriodoPlanejamentoChangeMonth extends PeriodoPlanejamentoState {
  const PeriodoPlanejamentoChangeMonth(super.periodo);
}
