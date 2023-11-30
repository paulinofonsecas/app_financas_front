import 'dart:async';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/tipo_conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/conta/cubit/create_conta_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/mostrar_na_tela_inicial_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/saldo_inicial_text_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/tipo_conta_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_conta_event.dart';
part 'create_conta_state.dart';

class CreateContaBloc extends Bloc<CreateContaEvent, CreateContaState> {
  late final IContaService contaService;
  CreateContaBloc() : super(CreateContaInitial()) {
    contaService = locator();
    on<GravarContaEvent>(_onGravarContaEvent);
  }

  FutureOr<void> _onGravarContaEvent(GravarContaEvent event, emit) async {
    emit(CreateContaLoading());
    try {
      var context = event.context;

      var nome = event.nomeConta;
      var descricao = '';
      var mostrarNaTelaInicial = _getMostrarNaTelaInicial(context);
      var saldo = _getSaldoInicial(context);
      var instituicaoFinanceiraState = _getBanco(context);
      var tipoConta = _getTipoConta(context);
      var cor = _getColor(context);

      if (instituicaoFinanceiraState == null) {
        throw Exception('Selecione uma instituição financeira.');
      }

      var conta = Conta(
        id: 0,
        saldo: 0,
        saldoInicial: saldo,
        nome: nome,
        descricao: descricao,
        color: cor.color,
        banco: instituicaoFinanceiraState.banco,
        tipoConta: TipoConta.tipoContas
            .firstWhere((element) => element.id == tipoConta.tipoContaId),
        showInSoma: mostrarNaTelaInicial,
        totalDespesas: 0,
        totalReceitas: 0,
      );

      var result = await contaService.saveConta(conta);

      if (result is Left) {
        emit(
          CreateContaError(
            errorMessage: result.fold((l) => l.toString(), (r) => ''),
          ),
        );
        return;
      }

      emit(CreateContaSuccess(conta));
    } catch (e) {
      emit(
        const CreateContaError(
          errorMessage: 'Ocorreu um erro ao criar a conta.',
        ),
      );
    }
  }

  bool _getMostrarNaTelaInicial(BuildContext context) {
    return (context.read<MostrarNaTelaInicialCubit>().state.mostrarNaTelaicial);
  }

  CreateContaThemeChanged _getColor(BuildContext context) =>
      context.read<CreateContaThemeCubit>().state as CreateContaThemeChanged;

  double _getSaldoInicial(BuildContext context) {
    try {
      return double.parse((context.read<SaldoInicialTextCubit>().state
              as SaldoInicialTextChanged)
          .saldo);
    } catch (e) {
      return 0;
    }
  }

  TipoContaChanged _getTipoConta(BuildContext context) =>
      context.read<TipoContaCubit>().state as TipoContaChanged;

  InstituicaoFinanceiraSelecionada? _getBanco(BuildContext context) {
    return (context.read<InstituicaoFinanceiraCubit>().state)
        as InstituicaoFinanceiraSelecionada;
  }
}
