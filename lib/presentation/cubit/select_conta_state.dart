part of 'select_conta_cubit.dart';

sealed class SelectContaState extends Equatable {
  const SelectContaState();

  @override
  List<Object> get props => [];
}

final class SelectContaInitial extends SelectContaState {
  const SelectContaInitial(this.contaId);

  final int? contaId;

  @override
  List<Object> get props => [contaId ?? 0];
}
// select default conta

final class SelectContaLoading extends SelectContaState {}

final class SelectContaError extends SelectContaState {
  final String? errorMessage;

  const SelectContaError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage ?? ''];
}

final class SelectContaSuccess extends SelectContaState {
  final Conta conta;

  const SelectContaSuccess(this.conta);

  @override
  List<Object> get props => [conta];
}
