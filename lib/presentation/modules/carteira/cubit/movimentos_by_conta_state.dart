part of 'movimentos_by_conta_cubit.dart';

sealed class MovimentosByContaState extends Equatable {
  const MovimentosByContaState();

  @override
  List<Object> get props => [];
}

final class MovimentosByContaInitial extends MovimentosByContaState {}

final class MovimentosByContaLoading extends MovimentosByContaState {}

final class MovimentosByContaSuccess extends MovimentosByContaState {
  final List<Movimento> movimentos;
  final int nextPageKey;

  const MovimentosByContaSuccess(
    this.movimentos,
    this.nextPageKey,
  );

  @override
  List<Object> get props => [movimentos, nextPageKey];
}

final class MovimentosByContaLastSuccess extends MovimentosByContaState {
  final List<Movimento> movimentos;

  const MovimentosByContaLastSuccess(this.movimentos);

  @override
  List<Object> get props => [movimentos];
}

final class MovimentosByContaError extends MovimentosByContaState {
  final String? errorMessage;

  const MovimentosByContaError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class MovimentosByContaEmpty extends MovimentosByContaState {}
