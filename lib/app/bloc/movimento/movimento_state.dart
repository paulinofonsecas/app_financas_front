part of 'movimento_bloc.dart';

sealed class MovimentoState extends Equatable {
  const MovimentoState();
  
  @override
  List<Object> get props => [];
}

final class MovimentoInitial extends MovimentoState {}
