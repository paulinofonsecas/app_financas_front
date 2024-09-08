part of 'create_planejamento_bloc.dart';

abstract class CreatePlanejamentoEvent extends Equatable {
  const CreatePlanejamentoEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_create_planejamento_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomCreatePlanejamentoEvent extends CreatePlanejamentoEvent {
  /// {@macro custom_create_planejamento_event}
  const CustomCreatePlanejamentoEvent();
}

class FinishCreatePlanejamentoEvent extends CreatePlanejamentoEvent {
  const FinishCreatePlanejamentoEvent(this.planejamento);

  final Planejamento planejamento;

  @override
  List<Object> get props => [planejamento];
}
