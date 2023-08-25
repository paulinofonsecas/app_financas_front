// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Column(
            children: [
              Text(
                DateTime.now().toString().substring(0, 16),
              ),
              Text(
                valor,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: valor.startsWith('-')
                      ? kVermelhaColor
                      : kVerdeAccentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
