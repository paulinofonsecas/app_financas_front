import 'dart:async';

import 'package:app_financas/core/domain/entitys/movimentos_pendentes.dart';
import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:collection/collection.dart';
part 'movimentos_pendentes_event.dart';
part 'movimentos_pendentes_state.dart';

class MovimentosPendentesBloc
    extends Bloc<MovimentosPendentesEvent, MovimentosPendentesState> {
  MovimentosPendentesBloc() : super(const MovimentosPendentesInitial()) {
    _movimentoService = GetIt.I.get<IMovimentoService>();
    on<LoadMovimentosPendentesEvent>(_onLoadMovimentosPendentesEvent);
  }

  late final IMovimentoService _movimentoService;

  FutureOr<void> _onLoadMovimentosPendentesEvent(
    LoadMovimentosPendentesEvent event,
    Emitter<MovimentosPendentesState> emit,
  ) async {
    emit(const MovimentosPendentesLoading());
    final result = await _movimentoService.listMovimentosPendentes();

    result.fold(
      (l) => emit(MovimentosPendentesError(l.message)),
      (r) {
        final pendentes = r.groupListsBy((mov) => mov.tipoMovimentoId);

        final entradasPendentes = pendentes[TipoMovimento.ENTRADA] ?? [];
        final saidasPendentes = pendentes[TipoMovimento.SAIDA] ?? [];

        if (entradasPendentes.isEmpty && saidasPendentes.isEmpty) {
          emit(const MovimentosPendentesEmpty());
          return;
        }

        emit(
          MovimentosPendentesSuccess(
            [
              if (entradasPendentes.isNotEmpty)
                MovimentosPendentes(
                  tipoMovimentoId: TipoMovimento.ENTRADA,
                  movimentos: entradasPendentes,
                ),
              if (saidasPendentes.isNotEmpty)
                MovimentosPendentes(
                  tipoMovimentoId: TipoMovimento.SAIDA,
                  movimentos: saidasPendentes,
                ),
            ],
          ),
        );
      },
    );
  }
}
