// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'last_movimentos_state.dart';

class LastMovimentosCubit extends Cubit<LastMovimentosState> {
  late final MovimentoBloc _movimentoBloc;

  LastMovimentosCubit() : super(LastMovimentosInitialState()) {
    _movimentoBloc = locator();

    _movimentoBloc.stream.listen((event) {
      if (event is MovimentoGetMovimentosListOfDaySucess) {
        emit(LastMovimentosSuccess(event.movimentos));
      }

      if (event is MovimentoGetMovimentosListOfDayLoadingError) {
        emit(LastMovimentosError());
      }

      if (event is MovimentoGetMovimentosListOfDayLoading) {
        emit(LastMovimentosLoading());
      }

      if (event is MovimentoGetMovimentosListOfDayEmpty) {
        emit(LastMovimentosEmpty());
      }
    });
  }

  getLastMovimentos() {
    emit(LastMovimentosLoading());
    _movimentoBloc.add(MovimentoGetMovimentosListOfDayEvent());
  }

  
}
