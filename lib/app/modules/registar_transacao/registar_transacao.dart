// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/app/modules/registar_transacao/components/body.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/helders/helpers.dart';

import 'controllers/registar_transacao_controller.dart';

class RegistarTransacao extends StatelessWidget {
  const RegistarTransacao({
    Key? key,
    required this.movimentoType,
  }) : super(key: key);

  final int movimentoType;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegistarTransacaoController(
      movimentoType: movimentoType,
    ));

    return GetBuilder(
      init: controller,
      id: 'geral',
      builder: (context) {
        return Scaffold(
          backgroundColor: isReceita(controller.movimentoType)
              ? kVerdeColor
              : kVermelhaColor,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Body(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SuspendedButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SuspendedButton extends StatelessWidget {
  const SuspendedButton({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RegistarTransacaoController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () async {
            await controller.finalizarMovimento();
            if (controller.salvo) {
              Get.back(closeOverlays: true);
            }
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size(Get.size.width / 1.9, 45),
            backgroundColor: isReceita(controller.movimentoType)
                ? kVerdeForteColor
                : kVermelhaForteColor,
            foregroundColor: Colors.white,
            side: BorderSide(
              color: isReceita(controller.movimentoType)
                  ? kVerdeForteColor
                  : kVermelhaForteColor,
            ),
          ),
          child: Text(
            'Salvar',
            style: GoogleFonts.inter().copyWith(
              fontSize: 16,
            ),
          ),
        ),
        GutterLarge(),
      ],
    );
  }
}
