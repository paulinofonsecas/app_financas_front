import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/home/components/informacoes_sobre_contas_widget.dart';
import 'package:app_financas/presentation/modules/home/widgets/carteira/card_widget.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardListWidget extends StatefulWidget {
  const CardListWidget({super.key});

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  final controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<ContaMostrarNaTelaInicialCubit,
            ContaMostrarNaTelaInicialState>(
          listener: (context, state) {
            if (state is ContaMostrarNaTelaChanged) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
        BlocListener<ReajustarSaldoCubit, ReajustarSaldoState>(
          listener: (context, state) {
            if (state is ReajustarSaldoSuccess) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
        BlocListener<CreateContaBloc, CreateContaState>(
          listener: (context, state) {
            if (state is CreateContaSuccess) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
        BlocListener<RegistarTransacaoBloc, RegistarTransacaoState>(
          listener: (context, state) {
            if (state is RegistarTransacaoSuccess) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
      ],
      child: BlocBuilder<ContasCubit, ContasState>(
        buildWhen: (previous, current) =>
            previous != current && current is ContasListarContas,
        builder: (context, state) {
          if (state is ContasListarContasLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ContasListarContasError) {
            return Text('//${state.errorMessage}');
          }

          if (state is ContasListarContasEmpty) {
            return const Text('Sem contas para apresentar');
          }

          if (state is ContasListarContasSuccess) {
            var contas = state.contas;

            return Column(
              children: [
                InformacoesSobreContasWidget(
                  totalContas: contas.length,
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * .25,
                  child: CarouselView(
                    scrollDirection: Axis.horizontal,
                    shrinkExtent: size.width * .7,
                    itemExtent: size.width * .9,
                    controller: controller,
                    itemSnapping: true,
                    onTap: null,
                    children: contas.map((conta) {
                      return CardWidget(conta: conta);
                    }).toList(),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
