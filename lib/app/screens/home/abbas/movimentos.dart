// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class MovimentoItem extends StatelessWidget {
  const MovimentoItem({
    Key? key,
    required this.asset,
    required this.title,
    required this.conta,
    required this.valor,
    required this.avatarBgColor,
  }) : super(key: key);

  final Color avatarBgColor;
  final String asset;
  final String title;
  final String conta;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: kBlackColor.withOpacity(.5),
            radius: 24,
            child: Center(
              child: SvgPicture.asset(
                asset,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                conta,
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            valor,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valor.startsWith('-') ? kVermelhaColor : kVerdeAccentColor,
            ),
          ),
        ],
      ),
    );
  }
}
