part of 'create_conta_bloc.dart';

sealed class CreateContaState extends Equatable {
  const CreateContaState();

  @override
  List<Object> get props => [];
}

final class CreateContaInitial extends CreateContaState {}

final class CreateContaLoading extends CreateContaState {}

final class CreateContaSuccess extends CreateContaState {
  final Conta conta;

  const CreateContaSuccess(this.conta);

  @override
  List<Object> get props => [conta];
}

final class CreateContaError extends CreateContaState {
  final String errorMessage;

  const CreateContaError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
