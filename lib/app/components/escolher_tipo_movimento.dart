import 'package:app_financas/app/modules/registar_entrada/registar_entrada.dart';
import 'package:app_financas/app/utils.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomEscolherTipoMovimento extends StatelessWidget {
  const BottomEscolherTipoMovimento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * .25,
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
                      Get.to(
                        const RegistarSaida(),
                        arguments: TipoMovimento.entrada,
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
                      // Get.to(
                      //   const AdicionarMovimentos(),
                      //   arguments: TipoMovimento.saida,
                      // );
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
