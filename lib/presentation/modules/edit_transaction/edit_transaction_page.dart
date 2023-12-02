// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/presentation/modules/edit_transaction/components/body.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/helpers.dart';

import 'controllers/edit_transacao_controller.dart';

class EditTransactionPage extends StatelessWidget {
  const EditTransactionPage({
    Key? key,
    required this.movimentoType,
    required this.movimento,
  }) : super(key: key);

  final int movimentoType;
  final Movimento movimento;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditTransacaoController(
      movimentoType: movimentoType,
      movimento: movimento,
    ));
    // controller.resetVariables();

    return GetBuilder(
      init: controller,
      id: 'geral',
      builder: (context) {
        return Scaffold(
          backgroundColor: isReceita(controller.movimentoType)
              ? kVerdeColor
              : kVermelhaColor,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Body(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SuspendedButton(),
                ),
              ],
            ),
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
    var controller = Get.find<EditTransacaoController>();
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          !controller.alterandoTransacao.value
              ? OutlinedButton(
                  onPressed: () async {
                    await controller.alterarTransacao();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.size.width / 6,
                      vertical: 20,
                    ),
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
                )
              : CircularProgressIndicator(),
          GutterLarge(),
        ],
      ),
    );
  }
}
