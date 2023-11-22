part of 'movimento_bloc.dart';

sealed class MovimentoState extends Equatable {
  const MovimentoState();

  @override
  List<Object> get props => [];
}

final class MovimentoInitial extends MovimentoState {}

// movimentos of day
final class MovimentoGetMovimentosListOfDayLoading extends MovimentoState {}

final class MovimentoGetMovimentosListOfDayLoadingError
    extends MovimentoState {}

final class MovimentoGetMovimentosListOfDayEmpty extends MovimentoState {}

final class MovimentoGetMovimentosListOfDaySucess extends MovimentoState {
  final List<Movimento> movimentos;

  const MovimentoGetMovimentosListOfDaySucess(this.movimentos);

  @override
  List<Object> get props => [movimentos];
}

// end movimentos of day

// movimentos paginated by conta
final class MovimentoGetLastPaginatedListByContaSuccess extends MovimentoState {
  final List<Movimento> movimentos;

  const MovimentoGetLastPaginatedListByContaSuccess(this.movimentos);

  @override
  List<Object> get props => [movimentos];
}

final class MovimentoGetPaginatedListByContaSuccess extends MovimentoState {
  final List<Movimento> movimentos;
  final int nextPageKey;

  const MovimentoGetPaginatedListByContaSuccess(
      this.movimentos, this.nextPageKey);

  @override
  List<Object> get props => [movimentos, nextPageKey];
}

final class MovimentoGetPaginatedListByContaError extends MovimentoState {
  final String errorMessage;

  const MovimentoGetPaginatedListByContaError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class MovimentoGetPaginatedListByContaLoading extends MovimentoState {}

final class MovimentoGetPaginatedListByContaEmpty extends MovimentoState {}

// end movimentos paginated by conta

// movimentos paginated

final class MovimentoGetPaginatedListSuccess extends MovimentoState {
  final List<Movimento> movimentos;
  final int nextPageKey;

  const MovimentoGetPaginatedListSuccess(this.movimentos, this.nextPageKey);

  @override
  List<Object> get props => [movimentos, nextPageKey];
}

final class MovimentoGetLastPaginatedListSuccess extends MovimentoState {
  final List<Movimento> movimentos;

  const MovimentoGetLastPaginatedListSuccess(this.movimentos);

  @override
  List<Object> get props => [movimentos];
}

final class MovimentoGetPaginatedListError extends MovimentoState {
  final String errorMessage;

  const MovimentoGetPaginatedListError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class MovimentoGetPaginatedListLoading extends MovimentoState {}

final class MovimentoGetPaginatedListEmpty extends MovimentoState {}

// end movimentos paginated