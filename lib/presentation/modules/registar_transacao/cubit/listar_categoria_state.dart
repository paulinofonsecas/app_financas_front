part of 'listar_categoria_cubit.dart';

sealed class ListarCategoriaState extends Equatable {
  const ListarCategoriaState();

  @override
  List<Object> get props => [];
}

final class ListarCategoriaInitial extends ListarCategoriaState {}

final class ListarCategoriasLoading extends ListarCategoriaState {}

final class ListarCategoriasSuccess extends ListarCategoriaState {
  final List<Categoria> categorias;

  const ListarCategoriasSuccess(this.categorias);

  @override
  List<Object> get props => [categorias];
}

final class ListarCategoriasError extends ListarCategoriaState {}

final class ListarCategoriasEmpty extends ListarCategoriaState {}
