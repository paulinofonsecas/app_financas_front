import 'package:app_financas/app/components/escolher_tipo_movimento.dart';
import 'package:app_financas/app/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/app/modules/conta_details/controllers/conta_details_page_controller.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/helders/format_helpers.dart';
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
    return Container(
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
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  Column(
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
                  const Spacer(),
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
                            Get.find<CarteiraPageController>()
                                .update(['geral']);
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
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const GutterSmall(),
                  Text(
                    '2% acima em relação ao mês passado',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
