part of 'home_page_cubit.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitialState extends HomePageState {}

final class HomePageLoadingMovimentosState extends HomePageState {}

final class HomePageGetPaginatedListError extends HomePageState {
  final String errorMessage;

  const HomePageGetPaginatedListError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class HomePageGetPaginatedListSuccess extends HomePageState {
  final List<Movimento> movimentos;
  final int nextPageKey;

  const HomePageGetPaginatedListSuccess(this.movimentos, this.nextPageKey);

  @override
  List<Object> get props => [movimentos, nextPageKey];
}

final class HomePageGetLastPaginatedListSuccess extends HomePageState {
  final List<Movimento> movimentos;

  const HomePageGetLastPaginatedListSuccess(this.movimentos);

  @override
  List<Object> get props => [movimentos];
}

abstract class HomePageListarContasState extends HomePageState {
  const HomePageListarContasState();

  @override
  List<Object> get props => [];
}

final class HomePageListarContasLoading extends HomePageListarContasState {}

final class HomePageListarContasError extends HomePageListarContasState {}

final class HomePageListarContasEmpty extends HomePageListarContasState {}

final class HomePageListarContasSuccess extends HomePageListarContasState {
  final List<Conta> contas;

  const HomePageListarContasSuccess(this.contas);

  @override
  List<Object> get props => [contas];
}
