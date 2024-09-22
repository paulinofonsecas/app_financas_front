import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/modules/registar_transacao/components/body.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/deletar_transacao_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistarTransacaoBody extends StatelessWidget {
  const RegistarTransacaoBody({
    super.key,
    required this.contaId,
  });

  final int? contaId;

  bool get isEditMode {
    return Get.isRegistered<Movimento>();
  }

  @override
  Widget build(BuildContext context) {
    var switchCubit = context.watch<SwitchTransacaoCubit>();
    var isEntrada = switchCubit.state is SwitchTransacaoEntrada;
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Theme.of(context).colorScheme.shadow
          : isEntrada
              ? kVerdeColor
              : kVermelhaColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Body(contaId: contaId),
            if (isEditMode) ...{
              DeletarTransacaoWidget(
                movimento: Get.find<Movimento>(),
              ),
            },
          ],
        ),
      ),
    );
  }
}

class DeletarTransacaoWidget extends StatelessWidget {
  const DeletarTransacaoWidget({super.key, required this.movimento});

  final Movimento movimento;

  void _showConfirmDeleteDialog({
    required BuildContext context,
    required Function() onConfirm,
    required Function() onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(kDefaultPadding),
          title: const Text('Confirmar'),
          actions: [
            TextButton(
              onPressed: () => onCancel(),
              child: Text(
                'Cancelar',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const GutterLarge(),
            FilledButton(
              onPressed: () => onConfirm(),
              child: const Text(
                'Confirmar',
              ),
            ),
          ],
          content: Text(
            'Tem certeza que deseja deletar esta transação?',
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Deletar transação'),
              onPressed: () {
                _showConfirmDeleteDialog(
                  context: context,
                  onConfirm: () {
                    Navigator.pop(context);
                    context
                        .read<DeleteTransacaoCubit>()
                        .deletarTransacao(movimento.id);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            const GutterLarge(),
          ],
        ),
      ),
    );
  }
}
