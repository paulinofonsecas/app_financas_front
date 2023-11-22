part of 'conta_bloc.dart';

sealed class ContaState extends Equatable {
  const ContaState();

  @override
  List<Object> get props => [];
}

final class ContaInitial extends ContaState {}

// contas

final class ListarContasLoading extends ContaState {}

final class ListarContasSuccess extends ContaState {
  final List<Conta> contas;

  const ListarContasSuccess(this.contas);

  @override
  List<Object> get props => [contas];
}

final class ListarContasError extends ContaState {
  final String? errorMessage;

  const ListarContasError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class ListarContasEmpty extends ContaState {}

// end listar contas

