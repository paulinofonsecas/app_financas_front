// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/app/components/movimento_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';

import 'components/abba_header.dart';

class Movimentos extends StatelessWidget {
  const Movimentos({
    super.key,
    required this.verMaisAction,
  });

  final GestureTapCallback? verMaisAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbbaHeader(
          title: 'Ultimos Movimentos',
          verMaisAction: verMaisAction,
        ),
        const SizedBox(height: kDefaultPadding),
        Text(
          'Hoje',
          style: GoogleFonts.inter(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            MovimentoItem(
              asset: 'assets/svgs/categories/desktop.svg',
              title: 'Adobe Photoshop',
              conta: 'Cartão do Bai',
              valor: '-Kz 1.000,00',
              avatarBgColor: kAmarelhoColor,
            ),
            MovimentoItem(
              asset: 'assets/svgs/categories/desktop.svg',
              title: 'Adobe Photoshop',
              conta: 'Cartão do Bai',
              valor: '-Kz 1.000,00',
              avatarBgColor: kAmarelhoColor,
            ),
            MovimentoItem(
              asset: 'assets/svgs/categories/Credit_card.svg',
              title: 'Adobe Photoshop',
              conta: 'Cartão do Bai',
              valor: '+Kz 1.000,00',
              avatarBgColor: kVerdeAccentColor,
            ),
          ],
        )
      ],
    );
  }
}
