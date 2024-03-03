part of 'movimentos_pendentes_bloc.dart';

abstract class MovimentosPendentesEvent extends Equatable {
  const MovimentosPendentesEvent();

  @override
  List<Object> get props => [];
}

class LoadMovimentosPendentesEvent extends MovimentosPendentesEvent {
  const LoadMovimentosPendentesEvent();
}
