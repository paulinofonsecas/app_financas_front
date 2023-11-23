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
    return Hero(
      tag: 'conta_${conta.id}',
      child: Material(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          padding: const EdgeInsets.all(kDefaultPadding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  const Gutter(),
                  Text(
                    conta.nome,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      _showCarteiraOptions(context);
                    },
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding * 3),
              BottomSection(conta: conta),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showCarteiraOptions(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (c) => Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2,
          top: kDefaultPadding * 2,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: Text(
                  'Arquivar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: Text(
                  'Editar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
              ),
            ],
          ),
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
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saldo atual',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const GutterTiny(),
                Text(
                  numberFormat.format(conta.saldo),
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
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
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onInverseSurface,
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
