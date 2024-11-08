// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movimentos_by_conta_state.dart';

class MovimentosByContaCubit extends Cubit<MovimentosByContaState> {
  late final MovimentoBloc _movimentoBloc;
  var pageSize = 10;

  MovimentosByContaCubit(this._movimentoBloc)
      : super(MovimentosByContaInitial()) {
    _movimentoBloc.stream.listen(
      (state) {
        if (state is MovimentoGetPaginatedListByContaLoading) {
          emit(MovimentosByContaLoading());
        }

        if (state is MovimentoGetPaginatedListByContaSuccess) {
          emit(MovimentosByContaSuccess(state.movimentos, state.nextPageKey));
        }

        if (state is MovimentoGetLastPaginatedListByContaSuccess) {
          emit(MovimentosByContaLastSuccess(state.movimentos));
        }

        if (state is MovimentoGetPaginatedListByContaError) {
          emit(MovimentosByContaError(errorMessage: state.errorMessage));
        }

        if (state is MovimentoGetPaginatedListByContaEmpty) {
          emit(MovimentosByContaEmpty());
        }
      },
    );
  }

  void getMovimentosByConta(int page, int contaId, [int tipoMovimento = 0]) {
    if (tipoMovimento > 2) {
      tipoMovimento = 0;
    }

    _movimentoBloc.add(MovimentoGetPaginatedListByContaEvent(
      page,
      pageSize,
      contaId,
      tipoMovimento,
    ));
  }
}
