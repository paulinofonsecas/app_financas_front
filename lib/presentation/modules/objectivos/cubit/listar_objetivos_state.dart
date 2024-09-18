part of 'listar_objetivos_cubit.dart';

sealed class ListarObjetivosState extends Equatable {
  const ListarObjetivosState();

  @override
  List<Object> get props => [];
}

final class ListarObjetivosInitial extends ListarObjetivosState {}

final class ListarObjetivosLoading extends ListarObjetivosState {}

final class ListarObjetivosEmpty extends ListarObjetivosState {}

final class ListarObjetivosLoaded extends ListarObjetivosState {
  final List<Objectivo> objectivos;

  const ListarObjetivosLoaded({required this.objectivos});

  @override
  List<Object> get props => [objectivos];
}

final class ListarObjetivosError extends ListarObjetivosState {
  final String message;
  const ListarObjetivosError(this.message);

  @override
  List<Object> get props => [message];
}
