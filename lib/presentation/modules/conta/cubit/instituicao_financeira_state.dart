part of 'instituicao_financeira_cubit.dart';

sealed class InstituicaoFinanceiraState extends Equatable {
  const InstituicaoFinanceiraState();

  @override
  List<Object> get props => [];
}

final class InstituicaoFinanceiraInitial extends InstituicaoFinanceiraState {}

final class InstituicaoFinanceiraLoading extends InstituicaoFinanceiraState {}

final class InstituicaoFinanceiraSuccess extends InstituicaoFinanceiraState {
  final List<Banco> bancos;

  const InstituicaoFinanceiraSuccess(this.bancos);

  @override
  List<Object> get props => [bancos];
}

final class InstituicaoFinanceiraError extends InstituicaoFinanceiraState {}

final class InstituicaoFinanceiraSelecionada
    extends InstituicaoFinanceiraState {
  final Banco banco;

  const InstituicaoFinanceiraSelecionada(this.banco);

  @override
  List<Object> get props => [banco];
}
