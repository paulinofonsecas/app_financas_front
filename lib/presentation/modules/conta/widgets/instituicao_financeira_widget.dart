import 'package:app_financas/domain/entities/banco.dart';
import 'package:app_financas/presentation/modules/conta/bottom_sheets/intituicoes_fin_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstituicaoFinanceiraWidget extends StatelessWidget {
  const InstituicaoFinanceiraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstituicaoFinanceiraCubit, InstituicaoFinanceiraState>(
      buildWhen: (p, current) => current is InstituicaoFinanceiraSelecionada,
      builder: (context, state) {
        late Banco banco;

        if (state is InstituicaoFinanceiraInitial) {
          return ListTile(
            onTap: () {
              InstitFinBottomSheet.openModalBottomSheet(
                context: context,
                cubit: context.read<InstituicaoFinanceiraCubit>(),
              );
            },
            title: const Text(
              'Instituição financeira',
            ),
            leading: const Icon(
              FontAwesomeIcons.building,
            ),
            trailing: const Icon(
              FontAwesomeIcons.chevronRight,
              size: 16,
            ),
          );
        }

        if (state is InstituicaoFinanceiraSelecionada) {
          banco = state.banco;

          return BancoListItem(
            onTap: () {
              InstitFinBottomSheet.openModalBottomSheet(
                context: context,
                cubit: context.read<InstituicaoFinanceiraCubit>(),
              );
            },
            banco: banco,
          );
        }

        return ListTile(
          onTap: () {
            InstitFinBottomSheet.openModalBottomSheet(
              context: context,
              cubit: context.read<InstituicaoFinanceiraCubit>(),
            );
          },
          title: const Text(
            'Instituição financeira',
          ),
          leading: const Icon(
            FontAwesomeIcons.building,
          ),
          trailing: const Icon(
            FontAwesomeIcons.chevronRight,
            size: 16,
          ),
        );
      },
    );
  }
}
