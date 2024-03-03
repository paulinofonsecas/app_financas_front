part of 'movimentos_pendentes_bloc.dart';

class MovimentosPendentesState extends Equatable {
  const MovimentosPendentesState({
    this.customProperty = 'Default Value',
  });

  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  MovimentosPendentesState copyWith({
    String? customProperty,
  }) {
    return MovimentosPendentesState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

class MovimentosPendentesInitial extends MovimentosPendentesState {
  const MovimentosPendentesInitial() : super();
}

class MovimentosPendentesLoading extends MovimentosPendentesState {
  const MovimentosPendentesLoading() : super();
}

class MovimentosPendentesError extends MovimentosPendentesState {
  const MovimentosPendentesError(this.message) : super();

  final String message;

  @override
  List<Object> get props => [message];
}

class MovimentosPendentesSuccess extends MovimentosPendentesState {
  const MovimentosPendentesSuccess(this.movimentosPendentes) : super();

  final List<MovimentosPendentes> movimentosPendentes;

  @override
  List<Object> get props => [movimentosPendentes];
}

class MovimentosPendentesEmpty extends MovimentosPendentesState {
  const MovimentosPendentesEmpty() : super();
}
