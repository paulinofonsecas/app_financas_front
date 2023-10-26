// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:app_financas/helders/string_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovimentoItem extends StatelessWidget {
  const MovimentoItem({
    Key? key,
    required this.movimento,
    required this.asset,
    required this.title,
    required this.conta,
    required this.valor,
    required this.avatarBgColor,
    required this.tipoMovimentoId,
    this.onTap,
  }) : super(key: key);

  final Movimento movimento;
  final int tipoMovimentoId;
  final Color avatarBgColor;
  final String asset;
  final String title;
  final String conta;
  final double valor;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: kBlackColor.withOpacity(.5),
                  radius: 22,
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
                      compressString(title, 30),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      movimento.data.day == DateTime.now().day
                          ? 'Hoje ${DateFormat('hh:mm').format(movimento.data)}'
                          : dateFormat.format(movimento.data),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      tipoMovimentoId == 1
                          ? numberFormat.format(valor)
                          : '- ${numberFormat.format(valor)}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: tipoMovimentoId == 1
                            ? kVerdeAccentColor
                            : kVermelhaColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
