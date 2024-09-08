part of 'search_list_categorias_cubit.dart';

sealed class SearchListCategoriasState extends Equatable {
  const SearchListCategoriasState();

  @override
  List<Object> get props => [];
}

final class SearchListCategoriasInitial extends SearchListCategoriasState {}

final class SearchListCategoriasLoading extends SearchListCategoriasState {}

final class SearchListCategoriasError extends SearchListCategoriasState {}

final class SearchListCategoriasEmpty extends SearchListCategoriasState {}

final class SearchListCategoriasLoaded extends SearchListCategoriasState {
  final List<Categoria> categorias;

  const SearchListCategoriasLoaded({required this.categorias});

  @override
  List<Object> get props => [categorias];
}
