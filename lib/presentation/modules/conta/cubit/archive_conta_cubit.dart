import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'arch_and_unarch_state.dart';

class ArchiveContaCubit extends Cubit<ArchiveContaState> {
  ArchiveContaCubit() : super(ArchiveContaInitial());

  final IContaUseCases _contaUseCase = getIt.get<IContaUseCases>();

  void archive(int contaId) async {
    emit(ArchiveContaLoading());

    final result = await _contaUseCase.arquivarConta(contaId);

    result.fold(
      (l) => emit(ArchiveContaError(l.message)),
      (r) => emit(ArchiveContaSuccess()),
    );
  }
}
