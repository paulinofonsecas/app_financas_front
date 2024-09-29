part of 'criar_sub_categoria_cubit.dart';

/// {@template criar_sub_categoria}
/// CriarSubCategoriaState description
/// {@endtemplate}
class CriarSubCategoriaState extends Equatable {
  /// {@macro criar_sub_categoria}
  const CriarSubCategoriaState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current CriarSubCategoriaState with property changes
  CriarSubCategoriaState copyWith({
    String? customProperty,
  }) {
    return CriarSubCategoriaState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template criar_sub_categoria_initial}
/// The initial state of CriarSubCategoriaState
/// {@endtemplate}
class CriarSubCategoriaInitial extends CriarSubCategoriaState {}

class CriarSubCategoriaEdit extends CriarSubCategoriaState {
  final Categoria subCategoria;

  const CriarSubCategoriaEdit(this.subCategoria);

  @override
  List<Object> get props => [subCategoria];
}

class CriarSubCategoriaLoading extends CriarSubCategoriaState {}

class CriarSubCategoriaFailed extends CriarSubCategoriaState {
  final String message;

  const CriarSubCategoriaFailed(this.message);

  @override
  List<Object> get props => [message];
}

class CriarSubCategoriaSuccess extends CriarSubCategoriaState {}
