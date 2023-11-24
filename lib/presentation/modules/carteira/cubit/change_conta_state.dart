part of 'change_conta_cubit.dart';

sealed class ChangeContaState extends Equatable {
  const ChangeContaState();

  @override
  List<Object> get props => [];
}

class ChageContaInitial extends ChangeContaState {}

class ContasUpdateContaIndex extends ChangeContaState {
  final int index;

  const ContasUpdateContaIndex(this.index);

  @override
  List<Object> get props => [index];
}
