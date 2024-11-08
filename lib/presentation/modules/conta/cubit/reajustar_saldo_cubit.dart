import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reajustar_saldo_state.dart';

class ReajustarSaldoCubit extends Cubit<ReajustarSaldoState> {
  late final IMovimentoUseCases _movimentoService;
  ReajustarSaldoCubit() : super(const ReajustarSaldoInitial()) {
    _movimentoService = getIt();
  }

  Future<void> reajustarSaldo(Conta conta) async {
    var ajuste = state.saldo - conta.saldo; // tipo de reajuste

    var movimentoReajuste = Movimento.make(
      contaId: conta.id,
      tipoMovimentoId: ajuste > 0 ? 1 : 2,
      valor: ajuste.abs(),
      data: DateTime.now(),
      confirmado: true,
      descricao: 'Reajuste de saldo',
      categoriaMovimentoId: 303030,
      obsMovimento: '',
    );

    var result = await _movimentoService.saveMovimento(movimentoReajuste);

    if (result is Right) {
      emit(const ReajustarSaldoSuccess());
    } else {
      emit(const ReajustarSaldoError());
    }
  }

  void updateNewSaldo(String text) {
    if (double.tryParse(text) == null) {
      text = '0';
      return;
    }

    emit(SaldoChanged(double.parse(text)));
  }
}
