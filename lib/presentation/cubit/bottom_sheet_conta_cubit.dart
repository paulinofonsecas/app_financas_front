import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/repositories/i_conta_repository.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_sheet_conta_state.dart';

class BottomSheetContaCubit extends Cubit<BottomSheetContaState> {
  late final IContaRepository _contaService;

  BottomSheetContaCubit() : super(BottomSheetContaInitial()) {
    _contaService = getIt();
  }

  void listContas() async {
    emit(ListarContasLoading());

    var result = await _contaService.listContas();

    result.fold(
      (l) => emit(ListarContasError(errorMessage: l.message)),
      (r) => emit(ListarContasSuccess(r)),
    );
  }
}
