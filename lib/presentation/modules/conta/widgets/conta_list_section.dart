import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/conta/view/create_conta_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta_list_item.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../cubit/conta_periodo_picker_cubit_cubit.dart';
import '../view/conta_details.dart';

class ContaListSection extends StatelessWidget {
  const ContaListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ContaBloc>().add(ListarContasAtEvent(DateTime.now().month));

    return MultiBlocListener(
      listeners: [
        BlocListener<ContaPeriodoPickerCubit, ContaPeriodoPickerState>(
          listener: (context, state) {
            if (state is ContaPeriodoPickerChanged) {
              context.read<ContaBloc>().add(ListarContasAtEvent(state.mes));
            }
          },
        ),
        BlocListener<ReajustarSaldoCubit, ReajustarSaldoState>(
          listener: (context, state) {
            if (state is ReajustarSaldoSuccess) {
              context
                  .read<ContaBloc>()
                  .add(ListarContasAtEvent(DateTime.now().month));
            }
          },
        ),
        BlocListener<CreateContaBloc, CreateContaState>(
          listener: (context, state) {
            if (state is CreateContaSuccess) {
              context
                  .read<ContaBloc>()
                  .add(ListarContasAtEvent(DateTime.now().month));
            }
          },
        ),
        BlocListener<ContaMostrarNaTelaInicialCubit, ContaMostrarNaTelaInicialState>(
          listener: (context, state) {
            if (state is ContaMostrarNaTelaChanged) {
              context
                  .read<ContaBloc>()
                  .add(ListarContasAtEvent(DateTime.now().month));
            }
          },
        ),
      ],
      child: BlocBuilder<ContaBloc, GContaState>(
        buildWhen: (prev, state) => prev != state,
        builder: (context, state) {
          if (state is ListarContasLoading) {
            return const CircularProgressIndicator();
          }

          if (state is ListarContasError) {
            return const Text('Erro ao listar contas');
          }

          if (state is ListarContasEmpty) {
            return const Text('Nenhuma conta cadastrado');
          }

          if (state is ListarContasSuccess) {
            return _ContentBody(contas: state.contas);
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _ContentBody extends StatelessWidget {
  const _ContentBody({
    required this.contas,
  });

  final List<Conta> contas;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(
          contas.length,
          (index) => ContaListItem(
            conta: contas[index],
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) {
                  return ContaMonstDetailsPage(
                    conta: contas[index],
                  );
                }),
              );
            },
          ),
        ).toList(),
        const GutterLarge(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).push(
                  CreateContaPage.route(),
                );
              },
              child: const Text(
                'Cadastrar conta',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
