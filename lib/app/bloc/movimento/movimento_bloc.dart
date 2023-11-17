// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'movimento_event.dart';
part 'movimento_state.dart';

class MovimentoBloc extends Bloc<MovimentoEvent, MovimentoState> {
  late final IMovimentoService movimentoService;

  MovimentoBloc(this.movimentoService) : super(MovimentoInitial()) {
    on<MovimentoGetPaginatedListByContaEvent>(
      _onMovimentoGetPaginatedListByConta,
    );
  }

  void _onMovimentoGetPaginatedListByConta(event, emit) async {
    final page = event.page;
    final pageSize = event.pageSize;

    try {
      final newItems = await _getPaginatedMovimentos(page, pageSize);

      if (newItems == null) {
        emit(
          const MovimentoGetPaginatedListByContaError(
            'Erro ao buscar movimentos',
          ),
        );
        return;
      }

      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        emit(MovimentoGetLastPaginatedListByContaSuccess(newItems));
      } else {
        final nextPageKey = page + 1;
        emit(MovimentoGetPaginatedListByContaSuccess(newItems, nextPageKey));
      }
    } catch (error) {
      emit(MovimentoGetPaginatedListByContaError(error.toString()));
    }
  }

  Future<List<Movimento>?> _getPaginatedMovimentos(
      int page, int pageSize) async {
    var result = await movimentoService.listPaginatedMovimentos(page, pageSize);

    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      return null;
    }
  }
}
