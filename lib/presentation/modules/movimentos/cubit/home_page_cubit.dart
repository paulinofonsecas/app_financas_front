// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:app_financas/domain/usecases/i_saldos_usecase.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  late final MovimentoBloc _movimentoBloc;
  late final ISaldosUseCases _saldosService;
  final int pageSize = 10;

  HomePageCubit() : super(HomePageInitialState()) {
    _movimentoBloc = getIt();
    _saldosService = getIt();
    _startListeningMovimentoUpdates();
    _movimentoBloc.stream.listen(onMovimento);
  }

  void _startListeningMovimentoUpdates() {
    final movimentoProvider = getIt<IMovimentoUseCases>();
    movimentoProvider.addListener(() {
      getSaldoTotalEntradas();
      getSaldoTotalSaidas();
    });
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

    if (event is MovimentoGetPaginatedListEmpty) {
      emit(const HomePageGetLastPaginatedListSuccess([]));
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

  Future<double> getSaldoTotalEntradasByConta(int contaId) async {
    final result = await _saldosService.getEntradasByConta(contaId);
    return result.getOrElse(() => 0);
  }

  Future<double> getSaldoTotalSaidasByConta(int contaId) async {
    final result = await _saldosService.getSaidasByConta(contaId);
    return result.getOrElse(() => 0);
  }

  void dispose() {
    _movimentoBloc.close();
  }
}
