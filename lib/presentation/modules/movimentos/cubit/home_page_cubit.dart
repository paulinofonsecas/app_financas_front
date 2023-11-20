// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/bloc/conta/conta_bloc.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  late final MovimentoBloc _movimentoBloc;
  late final ContaBloc _contaBloc;
  final int page = 1;
  final int pageSize = 10;

  HomePageCubit() : super(HomePageInitialState()) {
    _movimentoBloc = locator();
    _contaBloc = locator();

    _movimentoBloc.stream.listen(onMovimento);
    _contaBloc.stream.listen(onConta);
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

  void getContas() {
    _contaBloc.add(ListarContasEvent());
  }

  void dispose() {
    _movimentoBloc.close();
  }
}
