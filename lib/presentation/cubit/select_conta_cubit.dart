import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_conta_state.dart';

class SelectContaCubit extends Cubit<SelectContaState> {
  SelectContaCubit(int? i) : super(SelectContaInitial(i)) {
    _contaService = getIt();
  }

  late final IContaService _contaService;

  void selectDefaultConta(int? contaId) async {
    emit(SelectContaLoading());

    var result = await _contaService.listContas();

    if (result is Right) {
      final contas = result.getOrElse(() => []);
      if (contaId == null) {
        emit(SelectContaSuccess(contas.first));
      } else {
        final conta = contas.firstWhere(
          (element) => element.id == contaId,
          orElse: () => contas.first,
        );
        emit(SelectContaSuccess(conta));
      }
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
