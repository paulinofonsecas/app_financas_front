part of 'select_categoria_cubit.dart';

sealed class SelectCategoriaState extends Equatable {
  const SelectCategoriaState();

  @override
  List<Object> get props => [];
}

final class SelectCategoriaInitial extends SelectCategoriaState {}

final class SelectCategoriaLoading extends SelectCategoriaState {}

final class SelectCategoriaError extends SelectCategoriaState {}

final class SelectCategoriaChanged extends SelectCategoriaState {
  const SelectCategoriaChanged(this.categoria);

  final Categoria categoria;

  @override
  List<Object> get props => [categoria];
}
