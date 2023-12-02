import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/presentation/modules/registar_transacao/components/body.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/helpers.dart';

import 'controllers/registar_transacao_controller.dart';

class RegistarTransacaoPage extends StatelessWidget {
  const RegistarTransacaoPage({
    super.key,
    required this.movimentoType,
    this.contaId,
  });

  final int movimentoType;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    return RegistarTransacaoView(
      movimentoType: movimentoType,
      contaId: contaId,
    );
  }
}

class RegistarTransacaoView extends StatelessWidget {
  const RegistarTransacaoView({
    Key? key,
    required this.movimentoType,
    this.contaId,
  }) : super(key: key);

  final int movimentoType;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegistarTransacaoController(
      movimentoType: movimentoType,
    ));

    return GetBuilder(
      init: controller,
      id: 'geral',
      builder: (c) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor:
                  controller.movimentoType == 1 ? kVerdeColor : kVermelhaColor,
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: Builder(builder: (context) {
            var isDarkMode = Theme.of(context).brightness == Brightness.dark;
            return Scaffold(
              backgroundColor: isDarkMode
                  ? Theme.of(context).colorScheme.shadow
                  : isReceita(controller.movimentoType)
                      ? kVerdeColor
                      : kVermelhaColor,
              body: SafeArea(
                bottom: false,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Body(contaId: contaId),
                    _BuildActionButton(
                      movimentoType: controller.movimentoType,
                      controller: controller,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _BuildActionButton extends StatelessWidget {
  const _BuildActionButton({
    required this.movimentoType,
    required this.controller,
  });

  final int movimentoType;
  final RegistarTransacaoController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultActionButton(
            text: 'Salvar',
            backgroundColor:
                movimentoType == 1 ? kVerdeForteColor : kVermelhaForteColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              await controller.finalizarMovimento();
              if (controller.salvo) {
                Get.back(closeOverlays: true);
              }
            },
          ),
          const GutterLarge(),
        ],
      ),
    );
  }
}
