import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/campos_mixin.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/confirmar_transacao_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/descricao_text_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/obs_text_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_data_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/valor_transacao_cubit.dart';

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
    on<SalvarTransacaoEvent>(onRegistarTransacao);
  }

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
    if (valorTransacao == null || valorTransacao <= 0) {
      showErrorMessage('Valor', 'Coloque um valor correto para o movimento');
    }

    var confimarTransacao = getConfirmatedTransacao(context, emit);

    var descricao = getDescricaoTransacao(context, emit);
    if (descricao == null || descricao.isEmpty) {
      showErrorMessage('Descrição vazia', 'Preencha a descrição do movimento');
    }

    var obs = getObsTransacao(context, emit);
    if (obs == null || obs.isEmpty) {
      return;
    }

    var data = getDataTransacao(context, emit);

    var categoria = getCategoriaTransacao(context, emit);
    if (categoria == null) {
      return;
    }

    var conta = getContaTransacao(context, emit);
    if (conta == null) {
      return;
    }


    var movimento = Movimento.make(
      valor: valorTransacao!,
      data: data!,
      descricao: descricao!,
      contaId: conta!.id,
      tipoMovimentoId: ,
      categoriaMovimentoId: categoriaSelectedId,
      obsMovimento: obsMovimento,
      confirmado: confirmado.value,
    );

    var result = await movimentoService.saveMovimento(movimento);

    if (result is Right) {
      showSucessMessage('Sucesso', 'Movimento registrado com sucesso');
      salvo = true;
    } else {
      var error = result.swap().getOrElse(() => HttpException('message'));

      if (result is Left && error is SaldoInsuficiente) {
        showErrorMessage(
          'Saldo insuficiente',
          'O saldo do cartão é insuficiente para realizar o movimento',
        );
      } else {
        showErrorMessage(
          'Erro',
          'Erro ao registrar movimento',
        );
      }
      salvandoMovimento.value = false;
    }
  }
}
