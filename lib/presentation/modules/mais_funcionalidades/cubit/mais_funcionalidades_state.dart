part of 'mais_funcionalidades_cubit.dart';

/// {@template mais_funcionalidades}
/// MaisFuncionalidadesState description
/// {@endtemplate}
class MaisFuncionalidadesState extends Equatable {
  /// {@macro mais_funcionalidades}
  const MaisFuncionalidadesState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current MaisFuncionalidadesState with property changes
  MaisFuncionalidadesState copyWith({
    String? customProperty,
  }) {
    return MaisFuncionalidadesState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}
/// {@template mais_funcionalidades_initial}
/// The initial state of MaisFuncionalidadesState
/// {@endtemplate}
class MaisFuncionalidadesInitial extends MaisFuncionalidadesState {
  /// {@macro mais_funcionalidades_initial}
  const MaisFuncionalidadesInitial() : super();
}
