part of 'contas_cubit.dart';

sealed class ContasState extends Equatable {
  const ContasState();

  @override
  List<Object> get props => [];
}

final class ContasInitial extends ContasState {}

final class ContasListarContasLoading extends ContasState {}

final class ContasListarContasSuccess extends ContasState {
  final List<Conta> contas;

  const ContasListarContasSuccess(this.contas);

  @override
  List<Object> get props => [contas];
}

final class ContasListarContasError extends ContasState {
  final String? errorMessage;

  const ContasListarContasError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class ContasListarContasEmpty extends ContasState {}
