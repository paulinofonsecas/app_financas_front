// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_tipo_movimento_state.dart';

class ChangeTipoMovimentoCubit extends Cubit<ChangeTipoMovimentoState> {
  ChangeTipoMovimentoCubit() : super(const ChangeTipoMovimentoChanged(0));

  void updateTipoMovimento(int index) {
    emit(ChangeTipoMovimentoChanged(index));
  }
}
