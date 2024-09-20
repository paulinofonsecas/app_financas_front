part of 'criar_categoria_cubit.dart';

sealed class CriarCategoriaState extends Equatable {
  const CriarCategoriaState();

  @override
  List<Object> get props => [];
}

final class CriarCategoriaInitial extends CriarCategoriaState {}

final class CriarCategoriaSuccess extends CriarCategoriaState {}

final class CriarCategoriaError extends CriarCategoriaState {}
