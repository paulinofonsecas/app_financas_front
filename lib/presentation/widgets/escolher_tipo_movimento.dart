// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/presentation/pages/registar_transacao/registar_transacao.dart';
import 'package:app_financas/presentation/helders/constants.dart';

class BottomEscolherTipoMovimento extends StatelessWidget {
  const BottomEscolherTipoMovimento({
    Key? key,
    required this.cloused,
    this.contaId,
  }) : super(key: key);

  final Function cloused;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * .25,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Text(
              'Selecione o tipo de movimento',
              style: Get.textTheme.titleLarge,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomSecondaryButton(
                    label: 'Entrada',
                    color: kVerdeAccentColor,
                    onTap: () {
                      Get.to(RegistarTransacao(
                        movimentoType: 1,
                        contaId: contaId,
                      ))?.then(
                        (value) {
                          cloused();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: CustomSecondaryButton(
                    label: 'Saida',
                    color: kVermelhaColor,
                    onTap: () {
                      Get.to(RegistarTransacao(
                        movimentoType: 2,
                        contaId: contaId,
                      ))?.then((value) {
                        cloused();
                      });
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton({
    super.key,
    required this.label,
    required this.color,
    this.onTap,
  });

  final String label;
  final Color color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(15),
        splashColor: color,
        hoverColor: color.withAlpha(120),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
