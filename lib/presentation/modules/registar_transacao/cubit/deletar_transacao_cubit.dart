import 'package:app_financas/score/domain/services/i_movimento_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'deletar_transacao_state.dart';

class DeleteTransacaoCubit extends Cubit<DeleteTransacaoState> {
  DeleteTransacaoCubit(this._movimentoService)
      : super(DeleteTransacaoInitial());

  final IMovimentoService _movimentoService;

  void deletarTransacao(int id) async {
    emit(DeleteTransacaoLoading());

    final result = await _movimentoService.deleteMovimento(id);

    result.fold(
      (failure) => emit(DeleteTransacaoError()),
      (success) => emit(DeleteTransacaoSuccess()),
    );
  }
}
