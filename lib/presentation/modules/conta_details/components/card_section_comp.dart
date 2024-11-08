import 'package:app_financas/presentation/components/escolher_tipo_movimento.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/conta/bloc/conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta_details/controllers/conta_details_page_controller.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSection extends StatelessWidget {
  const CardSection({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Hero(
        tag: 'conta_${conta.id}',
        child: Material(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kDefaultPadding * 1.5),
            margin: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const BackButton(),
                    const Gutter(),
                    Text(
                      conta.nome,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        _showCarteiraOptions(context);
                      },
                      icon: const Icon(
                        Icons.more_horiz,
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
                  getIt<ContaBloc>().add(ArquivarContaEvent(conta: conta));
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
              const Divider(),
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
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const GutterTiny(),
                Text(
                  numberFormat.format(conta.saldo),
                  style: GoogleFonts.inter(
                    fontSize: 24,
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
              ),
              padding: const EdgeInsets.all(kDefaultPadding / .95),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
