part of 'categoria_bloc.dart';

sealed class CategoriaState extends Equatable {
  const CategoriaState();

  @override
  List<Object> get props => [];
}

final class CategoriaInitial extends CategoriaState {}

final class CategoriaLoading extends CategoriaState {}

final class CategoriaSuccess extends CategoriaState {
  final Categoria categoria;

  const CategoriaSuccess(this.categoria);

  @override
  List<Object> get props => [categoria];
}

final class CategoriaError extends CategoriaState {
  final String errorMessage;

  const CategoriaError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
