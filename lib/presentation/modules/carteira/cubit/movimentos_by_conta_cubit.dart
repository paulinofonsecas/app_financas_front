import 'package:app_financas/core/domain/entitys/movimento.dart';
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

  void getMovimentosByConta(int page, int contaId) {
    _movimentoBloc.add(MovimentoGetPaginatedListByContaEvent(
      page,
      pageSize,
      contaId,
    ));
  }
}
