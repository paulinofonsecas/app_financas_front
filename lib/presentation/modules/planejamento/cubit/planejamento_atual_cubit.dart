import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/core/domain/services/i_planejamento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'planejamento_atual_state.dart';

class PlanejamentoAtualCubit extends Cubit<PlanejamentoAtualState> {
  PlanejamentoAtualCubit(this._service) : super(PlanejamentoAtualInitial());

  final IPlanejamentoService _service;

  void getPlanejamentoAtual() async {
    emit(PlanejamentoAtualLoading());

    await _service.deletePlanejamento('00000000-0000');
    // await _service.createPlanejamento(Planejamento.fake(
    //   itens: [
    //     ItemPlanejamento(
    //       id: 1,
    //       categoria: Categoria.fake(),
    //       plafound: 100000,
    //     ),
    //     ItemPlanejamento(
    //       id: 2,
    //       categoria: Categoria.fake(),
    //       plafound: 100000,
    //     ),
    //   ],
    // ));

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
