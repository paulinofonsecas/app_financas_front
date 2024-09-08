part of 'planejamento_atual_cubit.dart';

sealed class PlanejamentoAtualState extends Equatable {
  const PlanejamentoAtualState();

  @override
  List<Object> get props => [];
}

final class PlanejamentoAtualInitial extends PlanejamentoAtualState {}

final class PlanejamentoAtualLoading extends PlanejamentoAtualState {}

final class PlanejamentoAtualEmpty extends PlanejamentoAtualState {}

final class PlanejamentoAtualFailled extends PlanejamentoAtualState {
  final String message;

  const PlanejamentoAtualFailled({required this.message});

  @override
  List<Object> get props => [message];
}

final class PlanejamentoAtualSuccess extends PlanejamentoAtualState {
  final Planejamento planejamento;

  const PlanejamentoAtualSuccess({required this.planejamento});

  @override
  List<Object> get props => [planejamento];
}
