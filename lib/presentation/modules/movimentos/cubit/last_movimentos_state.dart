part of 'last_movimentos_cubit.dart';

sealed class LastMovimentosState extends Equatable {
  const LastMovimentosState();

  @override
  List<Object> get props => [];
}

final class LastMovimentosLoading extends LastMovimentosState {}

final class LastMovimentosInitialState extends LastMovimentosState {}

final class LastMovimentosError extends LastMovimentosState {}

final class LastMovimentosEmpty extends LastMovimentosState {}

final class LastMovimentosSuccess extends LastMovimentosState {
  final List<Movimento> movimentos;

  const LastMovimentosSuccess(this.movimentos);

  @override
  List<Object> get props => [movimentos];
}
