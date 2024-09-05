part of 'planejamento_bloc.dart';

abstract class PlanejamentoEvent  extends Equatable {
  const PlanejamentoEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_planejamento_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomPlanejamentoEvent extends PlanejamentoEvent {
  /// {@macro custom_planejamento_event}
  const CustomPlanejamentoEvent();
}
