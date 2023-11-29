part of 'create_conta_bloc.dart';

sealed class CreateContaState extends Equatable {
  const CreateContaState();
  
  @override
  List<Object> get props => [];
}

final class CreateContaInitial extends CreateContaState {}
