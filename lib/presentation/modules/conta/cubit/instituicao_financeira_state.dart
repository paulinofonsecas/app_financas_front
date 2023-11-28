part of 'instituicao_financeira_cubit.dart';

sealed class InstituicaoFinanceiraState extends Equatable {
  const InstituicaoFinanceiraState();

  @override
  List<Object> get props => [];
}

final class InstituicaoFinanceiraInitial extends InstituicaoFinanceiraState {}

final class InstituicaoFinanceiraLoading extends InstituicaoFinanceiraState {}

final class InstituicaoFinanceiraSuccess extends InstituicaoFinanceiraState {}

final class InstituicaoFinanceiraError extends InstituicaoFinanceiraState {}
