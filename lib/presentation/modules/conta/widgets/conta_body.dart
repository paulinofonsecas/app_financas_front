import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';

import 'conta_list_section.dart';

/// {@template conta_body}
/// Body of the ContaPage.
///
/// Add what it does
/// {@endtemplate}
class ContaBody extends StatelessWidget {
  /// {@macro conta_body}
  const ContaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ContaBloc, GContaState>(
        bloc: context.read<ContaBloc>()..add(ListarContasEvent()),
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
            return ContaListSection(
              contas: state.contas,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
