import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/presentation/modules/conta/cubit/archive_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class ContaBottomSheet extends StatelessWidget {
  const ContaBottomSheet({super.key, required this.conta});

  final Conta conta;

  static Future<void> show(BuildContext context, Conta conta) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => BlocProvider.value(
        value: context.read<ArchiveContaCubit>(),
        child: ContaBottomSheet(conta: conta),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArchiveContaCubit, ArchiveContaState>(
      listener: (context, state) {
        if (state is ArchiveContaSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                context.read<ArchiveContaCubit>().archive(conta.id);
              },
              trailing: const Icon(Icons.archive_outlined),
              title: const Text('Arquivar conta'),
            ),
            const GutterLarge(),
          ],
        ),
      ),
    );
  }
}
