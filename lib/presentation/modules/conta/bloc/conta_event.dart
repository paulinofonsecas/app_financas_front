part of 'conta_bloc.dart';

sealed class ContaEvent extends Equatable {
  const ContaEvent();

  @override
  List<Object> get props => [];
}

class ListarContasEvent extends ContaEvent {}