import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/domain/services/i_banco_service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'instituicao_financeira_state.dart';

class InstituicaoFinanceiraCubit extends Cubit<InstituicaoFinanceiraState> {
  final IBancoService _bancoService;
  InstituicaoFinanceiraCubit(this._bancoService)
      : super(InstituicaoFinanceiraInitial());

  void listBancos() async {
    emit(InstituicaoFinanceiraLoading());

    try {
      var result = await _bancoService.listBancos();

      if (result is Left) emit(InstituicaoFinanceiraError());

      var bancos = result.getOrElse(() => []);
      emit(InstituicaoFinanceiraSuccess(bancos));
    } catch (e) {
      emit(InstituicaoFinanceiraError());
    }
  }

  void selecionarBanco(Banco banco) {
    emit(InstituicaoFinanceiraSelecionada(banco));
  }
}
