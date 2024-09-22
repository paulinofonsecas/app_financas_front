// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/components/bottom_sheet_contas.dart';
import 'package:app_financas/presentation/cubit/bottom_sheet_conta_cubit.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContaListItemComponent extends StatelessWidget {
  const ContaListItemComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContaListItemView();
  }
}

class ContaListItemView extends StatelessWidget {
  const ContaListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomSheetContasWidget.openModalBottomSheet(
          context,
          context.read<BottomSheetContaCubit>(),
          context.read<SelectContaCubit>(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            BlocBuilder<SelectContaCubit, SelectContaState>(
              builder: (context, state) {
                if (state is SelectContaInitial) {
                  context
                      .read<SelectContaCubit>()
                      .selectDefaultConta(state.contaId);
                  return const SizedBox();
                }

                if (state is SelectContaLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SelectContaError) {
                  return Text('//${state.errorMessage}');
                }

                if (state is SelectContaSuccess) {
                  return _ShowContaWidget(conta: state.conta);
                }

                return const SizedBox();
              },
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _ShowContaWidget extends StatelessWidget {
  const _ShowContaWidget({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Conta',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          conta.nome,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
