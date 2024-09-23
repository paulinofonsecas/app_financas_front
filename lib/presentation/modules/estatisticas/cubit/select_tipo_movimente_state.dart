part of 'select_tipo_movimente_cubit.dart';

sealed class SelectTipoMovimenteState extends Equatable {
  const SelectTipoMovimenteState(this.filter);

  final int filter;

  @override
  List<Object> get props => [filter];
}

final class SelectTipoMovimenteChange extends SelectTipoMovimenteState {
  const SelectTipoMovimenteChange(super.filter);
}
