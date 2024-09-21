part of 'filtro_cubit.dart';

sealed class FiltroState extends Equatable {
  const FiltroState(this.filtro);

  final FiltroSelectedType filtro;

  @override
  List<Object> get props => [filtro];
}

final class FiltroChanged extends FiltroState {
  const FiltroChanged(super.filtro);
}
