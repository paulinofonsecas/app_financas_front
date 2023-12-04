import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_sheet_conta_state.dart';

class BottomSheetContaCubit extends Cubit<BottomSheetContaState> {
  late final IContaService _contaService;

  BottomSheetContaCubit() : super(BottomSheetContaInitial()) {
    _contaService = getIt();
  }

  void listContas() async {
    emit(ListarContasLoading());

    var result = await _contaService.listContas();

    if (result is Right) {
      emit(ListarContasSuccess(result.getOrElse(() => [])));
    } else {
      emit(
        const ListarContasError(
          errorMessage: 'Ocorreu um erro ao carregar as contas',
        ),
      );
    }
  }
}
