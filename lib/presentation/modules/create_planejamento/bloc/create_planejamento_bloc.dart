import 'dart:async';

import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:app_financas/domain/usecases/i_planejamento_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_planejamento_event.dart';
part 'create_planejamento_state.dart';

class CreatePlanejamentoBloc
    extends Bloc<CreatePlanejamentoEvent, CreateNewPlanejamentoState> {
  CreatePlanejamentoBloc(this._planejamentoService)
      : super(const CreateNewPlanejamentoInitial()) {
    on<CustomCreatePlanejamentoEvent>(_onCustomCreatePlanejamentoEvent);
    on<FinishCreatePlanejamentoEvent>(_onFinishCreatePlanejamentoEvent);
  }

  final IPlanejamentoUseCases _planejamentoService;

  FutureOr<void> _onCustomCreatePlanejamentoEvent(
    CustomCreatePlanejamentoEvent event,
    Emitter<CreateNewPlanejamentoState> emit,
  ) {}

  FutureOr<void> _onFinishCreatePlanejamentoEvent(
    FinishCreatePlanejamentoEvent event,
    Emitter<CreateNewPlanejamentoState> emit,
  ) async {
    emit(const CreateNewPlanejamentoLoading());

    if (event.planejamento.plafound <= 0) {
      emit(const CreateNewPlanejamentoError('Plafound inválido'));
      return;
    }

    if (event.planejamento.itens.isEmpty) {
      emit(const CreateNewPlanejamentoError(
        'Planejamento vazio! Adicione as categorias do planejamento',
      ));
      return;
    }

    if (event.planejamento.itens.any(
      (element) => element.plafound <= 0,
    )) {
      emit(const CreateNewPlanejamentoError(
        'Existem itens com plafound inválido',
      ));
      return;
    }

    await _planejamentoService
        .createPlanejamento(event.planejamento)
        .then((result) => result.fold(
              (l) => emit(
                const CreateNewPlanejamentoError(
                    'Ocorreu um erro na criação do planejamento, tente novamente.'),
              ),
              (r) => emit(CreateNewPlanejamentoSuccess(r)),
            ))
        .catchError(
          (error) => emit(
            const CreateNewPlanejamentoError(
                'Ocorreu um erro na criação do planejamento, tente novamente.'),
          ),
        );
  }
}
