part of 'create_planejamento_bloc.dart';

/// {@template create_planejamento_state}
/// CreatePlanejamentoState description
/// {@endtemplate}
class CreatePlanejamentoState extends Equatable {
  /// {@macro create_planejamento_state}
  const CreatePlanejamentoState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current CreatePlanejamentoState with property changes
  CreatePlanejamentoState copyWith({
    String? customProperty,
  }) {
    return CreatePlanejamentoState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template create_planejamento_initial}
/// The initial state of CreatePlanejamentoState
/// {@endtemplate}
class CreatePlanejamentoInitial extends CreatePlanejamentoState {
  /// {@macro create_planejamento_initial}
  const CreatePlanejamentoInitial() : super();
}
