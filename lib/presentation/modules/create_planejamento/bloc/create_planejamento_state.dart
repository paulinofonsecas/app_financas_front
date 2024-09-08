part of 'create_planejamento_bloc.dart';

/// {@template create_planejamento_state}
/// CreatePlanejamentoState description
/// {@endtemplate}
class CreateNewPlanejamentoState extends Equatable {
  /// {@macro create_planejamento_state}
  const CreateNewPlanejamentoState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current CreatePlanejamentoState with property changes
  CreateNewPlanejamentoState copyWith({
    String? customProperty,
  }) {
    return CreateNewPlanejamentoState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template create_planejamento_initial}
/// The initial state of CreatePlanejamentoState
/// {@endtemplate}
class CreateNewPlanejamentoInitial extends CreateNewPlanejamentoState {
  const CreateNewPlanejamentoInitial() : super();
}

class CreateNewPlanejamentoLoading extends CreateNewPlanejamentoState {
  const CreateNewPlanejamentoLoading() : super();
}

class CreateNewPlanejamentoSuccess extends CreateNewPlanejamentoState {
  const CreateNewPlanejamentoSuccess(this.planejamento) : super();

  final Planejamento planejamento;

  @override
  List<Object> get props => [planejamento];
}

class CreateNewPlanejamentoError extends CreateNewPlanejamentoState {
  const CreateNewPlanejamentoError(this.message) : super();

  final String message;

  @override
  List<Object> get props => [];
}
