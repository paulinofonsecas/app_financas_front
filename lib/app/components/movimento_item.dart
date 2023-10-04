// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:app_financas/helders/string_helpers.dart';
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
    required this.tipoMovimentoId,
  }) : super(key: key);

  final int tipoMovimentoId;
  final Color avatarBgColor;
  final String asset;
  final String title;
  final String conta;
  final double valor;

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
                // ignore: deprecated_member_use
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
                compressString(title, 18),
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
                dateFormat.format(DateTime.now()),
              ),
              Text(
                tipoMovimentoId == 1
                    ? numberFormat.format(valor)
                    : '- ${numberFormat.format(valor)}',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      tipoMovimentoId == 1 ? kVerdeAccentColor : kVermelhaColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
