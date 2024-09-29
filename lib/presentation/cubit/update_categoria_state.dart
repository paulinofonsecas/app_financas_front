part of 'update_categoria_cubit.dart';

sealed class UpdateCategoriaState extends Equatable {
  const UpdateCategoriaState();

  @override
  List<Object> get props => [];
}

final class UpdateCategoriaInitial extends UpdateCategoriaState {}

final class UpdateCategoriaLoading extends UpdateCategoriaState {}

final class UpdateCategoriaFailed extends UpdateCategoriaState {}

final class UpdateCategoriaSuccess extends UpdateCategoriaState {
  final Categoria categoria;

  const UpdateCategoriaSuccess(this.categoria);

  @override
  List<Object> get props => [categoria];
}
