import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/modules/registar_transacao/components/body.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/widgets/deletar_transacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
