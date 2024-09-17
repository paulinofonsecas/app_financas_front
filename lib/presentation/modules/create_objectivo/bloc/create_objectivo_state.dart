part of 'create_objectivo_bloc.dart';

/// {@template create_objectivo_state}
/// CreateObjectivoState description
/// {@endtemplate}
class CreateObjectivoState extends Equatable {
  /// {@macro create_objectivo_state}
  const CreateObjectivoState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current CreateObjectivoState with property changes
  CreateObjectivoState copyWith({
    String? customProperty,
  }) {
    return CreateObjectivoState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template create_objectivo_initial}
/// The initial state of CreateObjectivoState
/// {@endtemplate}
class CreateObjectivoInitial extends CreateObjectivoState {}

class CreateObjectivoLoading extends CreateObjectivoState {}

class CreateObjectivoSuccess extends CreateObjectivoState {}

class CreateObjectivoError extends CreateObjectivoState {
  final String message;

  const CreateObjectivoError(this.message);

  @override
  List<Object> get props => [message];
}
