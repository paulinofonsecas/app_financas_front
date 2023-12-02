import 'package:app_financas/presentation/modules/registar_transacao/controllers/registar_transacao_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var controller = Get.find<RegistarTransacaoController>();

    var size = MediaQuery.of(context).size;
    return GetBuilder(
        init: controller,
        id: 'geral',
        builder: (c) {
          return Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            constraints: BoxConstraints(
              minHeight: size.height * .17,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Theme.of(context).colorScheme.shadow
                  : isReceita(controller.movimentoType)
                      ? kVerdeColor
                      : kVermelhaColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancelar',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SwitchTransactionButton(controller: controller),
                  ],
                ),
                const GutterLarge(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor da ${controller.movimentoType == 1 ? 'receita' : 'despesa'}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    TextFormField(
                      controller: controller.valorTextController,
                      onChanged: controller.onValorChange,
                      focusNode: FocusNode(canRequestFocus: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: '0,00',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        prefixText: 'Kz ',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
                const Gutter(),
              ],
            ),
          );
        });
  }
}

class SwitchTransactionButton extends StatelessWidget {
  const SwitchTransactionButton({
    super.key,
    required this.controller,
  });

  final RegistarTransacaoController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          controller.switchTransactionType();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 3,
            horizontal: kDefaultPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(90)),
            color: isReceita(controller.movimentoType)
                ? kVerdeForteColor
                : kVermelhaForteColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.movimentoType == 1 ? 'Receita' : 'Despesa',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GutterSmall(),
              const Icon(
                Icons.sync,
                color: Colors.white,
                weight: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
