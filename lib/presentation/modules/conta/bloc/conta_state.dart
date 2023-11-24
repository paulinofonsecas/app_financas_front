part of 'conta_bloc.dart';

/// {@template conta_state}
/// ContaState description
/// {@endtemplate}
class ContaState extends Equatable {
  /// {@macro conta_state}
  const ContaState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ContaState with property changes
  ContaState copyWith({
    String? customProperty,
  }) {
    return ContaState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template conta_initial}
/// The initial state of ContaState
/// {@endtemplate}
class ContaInitial extends ContaState {
  /// {@macro conta_initial}
  const ContaInitial() : super();
}
