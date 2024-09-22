// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/home/components/entry_saldo_value.dart';
import 'package:app_financas/presentation/modules/home/components/saldo_visibility.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';

class EntradasESaidas extends StatefulWidget {
  const EntradasESaidas({super.key});

  @override
  State<EntradasESaidas> createState() => _EntradasESaidasState();
}

class _EntradasESaidasState extends State<EntradasESaidas> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ContaMostrarNaTelaInicialCubit,
            ContaMostrarNaTelaInicialState>(
          listener: (context, state) {
            if (state is ContaMostrarNaTelaChanged) {
              getIt<HomePageCubit>().getSaldoTotalEntradas();
              getIt<HomePageCubit>().getSaldoTotalSaidas();
            }
          },
        ),
        BlocListener<ReajustarSaldoCubit, ReajustarSaldoState>(
          listener: (context, state) {
            if (state is ReajustarSaldoSuccess) {
              getIt<HomePageCubit>().getSaldoTotalEntradas();
              getIt<HomePageCubit>().getSaldoTotalSaidas();
            }
          },
        ),
        BlocListener<CreateContaBloc, CreateContaState>(
          listener: (context, state) {
            if (state is CreateContaSuccess) {
              getIt<HomePageCubit>().getSaldoTotalEntradas();
              getIt<HomePageCubit>().getSaldoTotalSaidas();
            }
          },
        ),
        //! Atualiza em funcao de um novo cadastro
        BlocListener<RegistarTransacaoBloc, RegistarTransacaoState>(
          listener: (context, state) {
            if (state is RegistarTransacaoSuccess) {
              getIt<HomePageCubit>().getSaldoTotalEntradas();
              getIt<HomePageCubit>().getSaldoTotalSaidas();
            }
          },
        ),
      ],
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: _rowValues(),
            ),
          ),
        ],
      ),
    );
  }

  Row _rowValues() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTotalEntradas(),
        SaldoVisibility(),
        _buildTotalSaidas(),
      ],
    );
  }

  BlocBuilder<HomePageCubit, HomePageState> _buildTotalEntradas() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      bloc: getIt<HomePageCubit>()..getSaldoTotalEntradas(),
      buildWhen: (previous, current) {
        return previous != current && current is HomePageGetEntradasSuccess;
      },
      builder: (context, state) {
        if (state is HomePageGetEntradasSuccess) {
          return EntrySaldoValue(
            asset: 'assets/svgs/home_page/Arrow_down.svg',
            title: 'Entradas',
            valor: state.entradas,
          );
        }

        if (state is HomePageGetEntradasError) {
          return Center(
            child: Text(
              '0.0',
            ),
          );
        }

        if (state is HomePageGetEntradasLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(child: Text('0.0'));
      },
    );
  }

  BlocBuilder<HomePageCubit, HomePageState> _buildTotalSaidas() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      bloc: getIt<HomePageCubit>()..getSaldoTotalSaidas(),
      buildWhen: (previous, current) {
        return previous != current && current is HomePageGetSaidasSuccess;
      },
      builder: (context, state) {
        if (state is HomePageGetSaidasSuccess) {
          return EntrySaldoValue(
            asset: 'assets/svgs/home_page/Arrow_up.svg',
            title: 'Saidas',
            valor: state.saidas,
          );
        }

        if (state is HomePageGetSaidasError) {
          return Center(
              child: Text(
            '0.0',
          ));
        }

        if (state is HomePageGetSaidasLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(child: Text('0.0'));
      },
    );
  }
}
