// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/bloc/conta/conta_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contas_state.dart';

class ContasCubit extends Cubit<ContasState> {
  late final ContaBloc _contaBloc;

  ContasCubit() : super(ContasInitial()) {
    _contaBloc = locator();

    _contaBloc.stream.listen((event) {
      if (event is ListarContasLoading) {
        emit(ContasListarContasLoading());
      }

      if (event is ListarContasSuccess) {
        emit(ContasListarContasSuccess(event.contas));
      }

      if (event is ListarContasError) {
        emit(ContasListarContasError(errorMessage: event.errorMessage));
      }

      if (event is ListarContasEmpty) {
        emit(ContasListarContasEmpty());
      }
    });
  }

  void getContas() {
    _contaBloc.add(ListarContasEvent());
  }
}
