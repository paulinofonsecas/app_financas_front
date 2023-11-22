// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/presentation/bloc/conta/conta_bloc.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  late final MovimentoBloc _movimentoBloc;
  late final ISaldosService _saldosService;
  final int pageSize = 10;

  HomePageCubit() : super(HomePageInitialState()) {
    _movimentoBloc = locator();
    _saldosService = locator();

    _movimentoBloc.stream.listen(onMovimento);
  }

  void onConta(event) {
    if (event is ListarContasSuccess) {
      emit(HomePageListarContasSuccess(event.contas));
    }

    if (event is ListarContasError) {
      emit(HomePageListarContasError());
    }

    if (event is ListarContasLoading) {
      emit(HomePageListarContasLoading());
    }

    if (event is ListarContasEmpty) {
      emit(HomePageListarContasEmpty());
    }
  }

  void onMovimento(event) {
    if (event is MovimentoGetPaginatedListSuccess) {
      emit(
        HomePageGetPaginatedListSuccess(event.movimentos, event.nextPageKey),
      );
    }

    if (event is MovimentoGetLastPaginatedListSuccess) {
      emit(HomePageGetLastPaginatedListSuccess(event.movimentos));
    }

    if (event is MovimentoGetPaginatedListError) {
      emit(HomePageGetPaginatedListError(event.errorMessage));
    }

    if (event is MovimentoGetPaginatedListLoading) {
      emit(HomePageLoadingMovimentosState());
    }
  }

  void getPaginatedMovimentos(int pageKey) {
    emit(HomePageLoadingMovimentosState());
    _movimentoBloc.add(MovimentoGetPaginatedListEvent(pageKey, pageSize));
  }

  void getSaldoTotal() async {
    emit(HomePageSaldoDisponivelLoading());
    var result = await _saldosService.getSaldoDisponivel();

    if (result is Right) {
      emit(HomePageSaldoDisponivelSuccess(result.getOrElse(() => 0)));
    } else if (result is Left) {
      emit(HomePageSaldoDisponivelError());
    }
  }

  void getSaldoTotalEntradas() {
    emit(HomePageGetEntradasLoading());

    _saldosService.getEntradas().then((value) {
      if (value is Right) {
        emit(HomePageGetEntradasSuccess(value.getOrElse(() => 0)));
      } else if (value is Left) {
        emit(HomePageGetSaidasError());
      }
    });
  }

  void getSaldoTotalSaidas() {
    emit(HomePageGetSaidasLoading());

    _saldosService.getSaidas().then((value) {
      if (value is Right) {
        emit(HomePageGetSaidasSuccess(value.getOrElse(() => 0)));
      } else if (value is Left) {
        emit(HomePageGetSaidasError());
      }
    });
  }

  void dispose() {
    _movimentoBloc.close();
  }
}
