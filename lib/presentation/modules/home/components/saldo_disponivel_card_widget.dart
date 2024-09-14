import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/home/components/card_widget.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'package:flutter/material.dart';

class SaldoDisponivelCardWidget extends StatefulWidget {
  const SaldoDisponivelCardWidget({super.key});

  @override
  State<SaldoDisponivelCardWidget> createState() =>
      _SaldoDisponivelCardWidgetState();
}

class _SaldoDisponivelCardWidgetState extends State<SaldoDisponivelCardWidget> {
  late final HomePageCubit homePageCubit;

  @override
  void initState() {
    homePageCubit = getIt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ContaMostrarNaTelaInicialCubit,
              ContaMostrarNaTelaInicialState>(
            listener: (context, state) {
              if (state is ContaMostrarNaTelaChanged) {
                homePageCubit.getSaldoTotal();
              }
            },
          ),
          BlocListener<ReajustarSaldoCubit, ReajustarSaldoState>(
            listener: (context, state) {
              if (state is ReajustarSaldoSuccess) {
                homePageCubit.getSaldoTotal();
              }
            },
          ),
          BlocListener<CreateContaBloc, CreateContaState>(
            listener: (context, state) {
              if (state is CreateContaSuccess) {
                homePageCubit.getSaldoTotal();
              }
            },
          ),
          BlocListener<RegistarTransacaoBloc, RegistarTransacaoState>(
            listener: (context, state) {
              if (state is RegistarTransacaoSuccess) {
                homePageCubit.getSaldoTotal();
              }
            },
          ),
        ],
        child: BlocBuilder<HomePageCubit, HomePageState>(
          bloc: homePageCubit..getSaldoTotal(),
          buildWhen: (previous, current) {
            return previous != current &&
                current is HomePageSaldoDisponivelState;
          },
          builder: (context, state) {
            if (state is HomePageSaldoDisponivelLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomePageSaldoDisponivelError) {
              return const Center(child: Text('Erro ao buscar contas'));
            }

            if (state is HomePageSaldoDisponivelEmpty) {
              return const Center(
                child: Text('Nenhum cartão cadastrado'),
              );
            }

            if (state is HomePageSaldoDisponivelSuccess) {
              return SaldoCardWidget(saldo: state.saldo);
            }

            return Container();
          },
        ),
      ),
    );
  }
}
