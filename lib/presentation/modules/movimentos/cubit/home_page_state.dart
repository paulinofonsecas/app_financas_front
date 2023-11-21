part of 'home_page_cubit.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitialState extends HomePageState {}

final class HomePageLoadingMovimentosState extends HomePageState {}

// movimentos
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

// end movimentos

// contas
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
// end contas

// saldos
abstract class HomePageSaldoDisponivelState extends HomePageState {
  const HomePageSaldoDisponivelState();

  @override
  List<Object> get props => [];
}

final class HomePageSaldoDisponivelLoading
    extends HomePageSaldoDisponivelState {}

final class HomePageSaldoDisponivelError extends HomePageSaldoDisponivelState {}

final class HomePageSaldoDisponivelEmpty extends HomePageSaldoDisponivelState {}

final class HomePageSaldoDisponivelSuccess
    extends HomePageSaldoDisponivelState {
  final double saldo;

  const HomePageSaldoDisponivelSuccess(this.saldo);

  @override
  List<Object> get props => [saldo];
}

// end saldos

// entradas
abstract class HomePageGetEntradasState extends HomePageState {
  const HomePageGetEntradasState();

  @override
  List<Object> get props => [];
}

final class HomePageGetEntradasLoading extends HomePageGetEntradasState {}

final class HomePageGetEntradasError extends HomePageGetEntradasState {}

final class HomePageGetEntradasEmpty extends HomePageGetEntradasState {}

final class HomePageGetEntradasSuccess extends HomePageGetEntradasState {
  final double entradas;

  const HomePageGetEntradasSuccess(this.entradas);

  @override
  List<Object> get props => [entradas];
}

// end entradas

// saidas
abstract class HomePageGetSaidasState extends HomePageState {
  const HomePageGetSaidasState();

  @override
  List<Object> get props => [];
}

final class HomePageGetSaidasLoading extends HomePageGetSaidasState {}

final class HomePageGetSaidasError extends HomePageGetSaidasState {}

final class HomePageGetSaidasEmpty extends HomePageGetSaidasState {}

final class HomePageGetSaidasSuccess extends HomePageGetSaidasState {
  final double saidas;

  const HomePageGetSaidasSuccess(this.saidas);

  @override
  List<Object> get props => [saidas];
}

// end saidas

