// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contas_state.dart';

class ContasCubit extends Cubit<ContasState> {
  late final ContaBloc _contaBloc;

  ContasCubit() : super(ContasInitial()) {
    _contaBloc = locator();

    _contaBloc.stream.listen((state) {
      if (state is ListarContasLoading) {
        emit(ContasListarContasLoading());
      }

      if (state is ListarContasSuccess) {
        emit(ContasListarContasSuccess(state.contas));
      }

      if (state is ListarContasError) {
        emit(ContasListarContasError(errorMessage: state.errorMessage));
      }

      if (state is ListarContasEmpty) {
        emit(ContasListarContasEmpty());
      }
    });
  }

  void getContas() {
    _contaBloc.add(ListarContasEvent());
  }
}
