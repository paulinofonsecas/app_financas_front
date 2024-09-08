import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/core/domain/services/i_planejamento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'planejamento_atual_state.dart';

class PlanejamentoAtualCubit extends Cubit<PlanejamentoAtualState> {
  PlanejamentoAtualCubit(this._service) : super(PlanejamentoAtualInitial());

  final IPlanejamentoService _service;

  void deletePlanejamentoAtual() async {
    emit(PlanejamentoAtualLoading());
    _service.deletePlanejamentoAtual().then((value) {
      value.fold(
        (l) {
          emit(PlanejamentoAtualFailled(
            message: 'Erro ao deletar o planejamento atual\n${l.message}',
          ));
        },
        (r) {
          getPlanejamentoAtual();
        },
      );
    });
  }

  void getPlanejamentoAtual() async {
    emit(PlanejamentoAtualLoading());

    _service.getPlanejamentoAtual().then((value) {
      value.fold(
        (l) {
          if (l is NaoExistePlanejamentoAtual) {
            emit(PlanejamentoAtualEmpty());
            return;
          }

          emit(
            PlanejamentoAtualFailled(
              message: 'Erro ao carregar o planejamento atual\n${l.message}',
            ),
          );
        },
        (r) {
          emit(
            PlanejamentoAtualSucess(planejamento: r),
          );
        },
      );
    });
  }
}
