part of 'change_tipo_movimento_cubit.dart';

sealed class ChangeTipoMovimentoState extends Equatable {
  final int index;
  const ChangeTipoMovimentoState(this.index);

  @override
  List<Object> get props => [index];
}

final class ChangeTipoMovimentoChanged extends ChangeTipoMovimentoState {
  const ChangeTipoMovimentoChanged(int index) : super(index);

  @override
  List<Object> get props => [index];
}
