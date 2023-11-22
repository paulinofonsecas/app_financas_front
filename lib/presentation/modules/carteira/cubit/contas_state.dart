part of 'contas_cubit.dart';

sealed class ContasState extends Equatable {
  const ContasState();

  @override
  List<Object> get props => [];
}

final class ContasInitial extends ContasState {}

final class ContasListarContas extends ContasState {
  const ContasListarContas();

  @override
  List<Object> get props => [];
}

final class ContasListarContasLoading extends ContasListarContas {}

final class ContasListarContasSuccess extends ContasListarContas {
  final List<Conta> contas;

  const ContasListarContasSuccess(this.contas);

  @override
  List<Object> get props => [contas];
}

final class ContasListarContasError extends ContasListarContas {
  final String? errorMessage;

  const ContasListarContasError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class ContasListarContasEmpty extends ContasListarContas {}
