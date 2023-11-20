import 'package:app_financas/presentation/components/escolher_tipo_movimento.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/conta_details/controllers/conta_details_page_controller.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSection extends StatelessWidget {
  const CardSection({
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 280,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pinkAccent,
              Colors.blue,
            ],
          ),
        ),
        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const BackButton(
                  color: Colors.white,
                ),
                const Gutter(),
                Text(
                  conta.nome,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            BottomSection(conta: conta),
          ],
        ),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: kDefaultPadding,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: kDefaultPadding,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saldo atual',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const GutterTiny(),
                Text(
                  numberFormat.format(conta.saldo),
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                customShowModalBottomSheet(
                  context,
                  isScrollControlled: false,
                  constraints: const BoxConstraints.tightFor(),
                  child: BottomEscolherTipoMovimento(
                    contaId: conta.id,
                    cloused: () {
                      Get.find<HomePageController>().update(['geral']);
                      Get.find<CarteiraPageController>().update(['geral']);
                      Get.back(closeOverlays: true);
                    },
                  ),
                ).then((value) {
                  Get.find<ContaDetailsPageController>().updateGeral();
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(kDefaultPadding / .95),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.white.withOpacity(.3),
        ),
        const GutterSmall(),
      ],
    );
  }
}
