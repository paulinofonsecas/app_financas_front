import 'dart:async';

import 'package:app_financas/domain/entities/movimentos_pendentes.dart';
import 'package:app_financas/domain/entities/tipo_movimento.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
part 'movimentos_pendentes_event.dart';
part 'movimentos_pendentes_state.dart';

class MovimentosPendentesBloc
    extends Bloc<MovimentosPendentesEvent, MovimentosPendentesState> {
  MovimentosPendentesBloc() : super(const MovimentosPendentesInitial()) {
    _movimentoService = getIt<IMovimentoUseCases>();
    _startListeningMovimentoUpdates();
    on<LoadMovimentosPendentesEvent>(_onLoadMovimentosPendentesEvent);
  }

  late final IMovimentoUseCases _movimentoService;

  void _startListeningMovimentoUpdates() {
    final movimentoProvider = getIt<IMovimentoUseCases>();
    movimentoProvider.addListener(() {
      add(const LoadMovimentosPendentesEvent());
    });
  }

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
