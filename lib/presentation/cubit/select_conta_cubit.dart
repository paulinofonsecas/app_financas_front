import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_conta_state.dart';

class SelectContaCubit extends Cubit<SelectContaState> {
  SelectContaCubit() : super(SelectContaInitial()) {
    _contaService = getIt();
  }

  late final IContaService _contaService;

  void selectDefaultConta() async {
    emit(SelectContaLoading());

    var result = await _contaService.listContas();

    if (result is Right) {
      emit(SelectContaSuccess(result.getOrElse(() => []).first));
    } else {
      emit(
        const SelectContaError(
          errorMessage: 'Ocorreu um erro a carregar a conta',
        ),
      );
    }
  }

  void selectConta(Conta conta) {
    emit(SelectContaSuccess(conta));
  }
}
