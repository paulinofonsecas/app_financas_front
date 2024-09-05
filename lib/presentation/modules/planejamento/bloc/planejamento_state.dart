part of 'planejamento_bloc.dart';

/// {@template planejamento_state}
/// PlanejamentoState description
/// {@endtemplate}
class PlanejamentoState extends Equatable {
  /// {@macro planejamento_state}
  const PlanejamentoState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current PlanejamentoState with property changes
  PlanejamentoState copyWith({
    String? customProperty,
  }) {
    return PlanejamentoState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template planejamento_initial}
/// The initial state of PlanejamentoState
/// {@endtemplate}
class PlanejamentoInitial extends PlanejamentoState {
  /// {@macro planejamento_initial}
  const PlanejamentoInitial() : super();
}
