import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'deletar_transacao_state.dart';

class DeleteTransacaoCubit extends Cubit<DeleteTransacaoState> {
  DeleteTransacaoCubit(this._movimentoService)
      : super(DeleteTransacaoInitial());

  final IMovimentoUseCases _movimentoService;

  void deletarTransacao(int id) async {
    emit(DeleteTransacaoLoading());

    final result = await _movimentoService.deleteMovimento(id);

    result.fold(
      (failure) => emit(DeleteTransacaoError()),
      (success) => emit(DeleteTransacaoSuccess()),
    );
  }
}
