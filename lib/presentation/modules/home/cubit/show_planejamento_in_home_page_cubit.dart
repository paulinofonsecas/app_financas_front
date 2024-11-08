import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:app_financas/domain/usecases/i_planejamento_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_planejamento_in_home_page_state.dart';

class ShowPlanejamentoInHomePageCubit
    extends Cubit<ShowPlanejamentoInHomePageState> {
  ShowPlanejamentoInHomePageCubit(this._service)
      : super(ShowPlanejamentoInHomePageInitial());

  final IPlanejamentoUseCases _service;

  void getPlanejamento() async {
    emit(ShowPlanejamentoInHomePageLoading());

    _service.getPlanejamentoAtual().then((value) {
      value.fold(
        (l) {
          if (l is NaoExistePlanejamentoAtual) {
            emit(ShowPlanejamentoInHomePageEmpty());
            return;
          }

          emit(
            ShowPlanejamentoInHomePageError(
              'Erro ao carregar o planejamento atual\n${l.message}',
            ),
          );
        },
        (r) {
          emit(
            ShowPlanejamentoInHomePageSuccess(r),
          );
        },
      );
    });
  }
}
