part of 'objectivos_bloc.dart';

/// {@template objectivos_state}
/// ObjectivosState description
/// {@endtemplate}
class ObjectivosState extends Equatable {
  /// {@macro objectivos_state}
  const ObjectivosState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ObjectivosState with property changes
  ObjectivosState copyWith({
    String? customProperty,
  }) {
    return ObjectivosState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template objectivos_initial}
/// The initial state of ObjectivosState
/// {@endtemplate}
class ObjectivosInitial extends ObjectivosState {
  /// {@macro objectivos_initial}
  const ObjectivosInitial() : super();
}
