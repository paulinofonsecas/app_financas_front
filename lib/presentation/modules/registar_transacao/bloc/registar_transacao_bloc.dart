import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';

import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/campos_mixin.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registar_transacao_event.dart';
part 'registar_transacao_state.dart';

enum ErrorType {
  confirmacaoInvalida,
  valorInvalidoOuVazio,
  dataInvalida,
  descricaoVazia,
  obsVazia,
  categoriaInvalida,
  contaInvalida,
}

class RegistarTransacaoBloc
    extends Bloc<RegistarTransacaoEvent, RegistarTransacaoState>
    with CamposMixin {
  RegistarTransacaoBloc() : super(RegistarTransacaoInitial()) {
    _movimentoService = getIt();
    on<SalvarTransacaoEvent>(onRegistarTransacao);
  }

  late final IMovimentoUseCases _movimentoService;

  void onRegistarTransacao(
    SalvarTransacaoEvent event,
    Emitter<RegistarTransacaoState> emit,
  ) async {
    var context = event.context;
    emit(RegistarTransacaoLoading());

    var tipoMovimento = isEntrada(context, emit);
    if (tipoMovimento == null) {
      showErrorMessage('Transacão', 'Erro ao varificar o tipo da transacão');
    }

    var valorTransacao = getValorTransacao(context, emit);
    if (valorTransacao == null) {
      showErrorMessage('Valor', 'Coloque um valor correto para o movimento');
      return;
    }

    var confimarTransacao = getConfirmatedTransacao(context, emit);

    var descricao = getDescricaoTransacao(context, emit);
    if (descricao == null || descricao.isEmpty) {
      showErrorMessage(
          'Descrição vazia', 'Preencha a descrição do movimento');
      return;
    }

    var obs = getObsTransacao(context, emit);
    if (obs == null) {
      showErrorMessage('Obs invalida',
          'Ocorreu um erro ao validar a observação. Tente novamente');
      return;
    }

    var data = getDataTransacao(context, emit);

    var categoria = getCategoriaTransacao(context, emit);
    if (categoria == null) {
      showErrorMessage(
        'Descricao invalida',
        'Ocorreu um erro ao validar a descricao. Tente novamente',
      );
      return;
    }

    var conta = getContaTransacao(context, emit);
    if (conta == null) {
      showErrorMessage(
        'Conta invalida',
        'Ocorreu um erro ao validar a conta. Tente novamente',
      );
      return;
    }

    var movimento = Movimento.make(
      id: event.movimento?.id,
      valor: valorTransacao,
      data: data!,
      descricao: descricao,
      contaId: conta.id,
      tipoMovimentoId: tipoMovimento == true ? 1 : 2,
      categoriaMovimentoId: categoria.id,
      subCategoria: categoria.subCategoria,
      obsMovimento: obs,
      confirmado: confimarTransacao,
    );

    var result = await _movimentoService.saveMovimento(movimento);

    if (result is Right) {
      emit(RegistarTransacaoSuccess());
    } else {
      var error = result
          .swap()
          .getOrElse(() => Failure('Erro desconhecido ao salvar a transacao'));

      if (result is Left && error is SaldoInsuficiente) {
        showErrorMessage(
          'Saldo insuficiente',
          'O saldo do cartão é insuficiente para realizar o movimento',
        );
      } else {
        if (kDebugMode) {
          print(error.message);
        }
        showErrorMessage(
          'Erro',
          'Erro ao registrar movimento',
        );
      }
    }
  }
}
