import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/confirmar_transacao_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/descricao_text_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/obs_text_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_data_cubit.dart';

import '../cubit/valor_transacao_cubit.dart';
import 'registar_transacao_bloc.dart';

mixin CamposMixin {
  bool? isEntrada(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      return (context.read<SwitchTransacaoCubit>().state
          is SwitchTransacaoEntrada);
    } catch (e) {
      return null;
    }
  }

  bool getConfirmatedTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      var confirmaTransCubit = context.read<ConfirmarTransacaoCubit>();

      return confirmaTransCubit.state.isTransacaoConfirmad;
    } catch (e) {
      return false;
    }
  }

  double? getValorTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      var valorTransacaoCubit = context.read<ValorTransacaoCubit>();

      var valorTransacao = valorTransacaoCubit.state;
      return double.parse(valorTransacao.valor);
    } on FormatException {
      emit(
        const RegistarTransacaoError(
          errorMessage: 'Erro ao converter o valor.',
          errorType: ErrorType.valorInvalidoOuVazio,
        ),
      );
      return null;
    }
  }

  String? getDescricaoTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      return context.read<DescricaoTextCubit>().state.descricao;
    } catch (e) {
      emit(
        const RegistarTransacaoError(
          errorMessage: 'Erro ao processar a descricao.',
          errorType: ErrorType.descricaoVazia,
        ),
      );
      return null;
    }
  }

  String? getObsTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      return context.read<ObsTextCubit>().state.obs;
    } catch (e) {
      return null;
    }
  }

  DateTime? getDataTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      return (context.read<SelectDataCubit>().state).date;
    } catch (e) {
      return null;
    }
  }

  Categoria? getCategoriaTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      return (context.read<SelectCategoriaCubit>().state
              as SelectCategoriaChanged)
          .categoria;
    } catch (e) {
      return null;
    }
  }

  Conta? getContaTransacao(
    BuildContext context,
    Emitter<RegistarTransacaoState> emit,
  ) {
    try {
      var state =
          (context.read<SelectContaCubit>().state as SelectContaSuccess);
      return state.conta;
    } catch (e) {
      return null;
    }
  }
}
