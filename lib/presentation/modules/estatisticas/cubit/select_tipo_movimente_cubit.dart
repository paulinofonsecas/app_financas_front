import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_tipo_movimente_state.dart';

class SelectTipoMovimentoCubit extends Cubit<SelectTipoMovimenteState> {
  SelectTipoMovimentoCubit()
      : super(const SelectTipoMovimenteChange(TipoMovimento.SAIDA));

  void changeFilter(int saida) {
    emit(SelectTipoMovimenteChange(saida));
  }
}
