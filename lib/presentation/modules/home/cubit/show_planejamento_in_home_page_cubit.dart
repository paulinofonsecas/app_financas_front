import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/core/domain/services/i_planejamento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_planejamento_in_home_page_state.dart';

class ShowPlanejamentoInHomePageCubit
    extends Cubit<ShowPlanejamentoInHomePageState> {
  ShowPlanejamentoInHomePageCubit(this._service)
      : super(ShowPlanejamentoInHomePageInitial());

  final IPlanejamentoService _service;

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
