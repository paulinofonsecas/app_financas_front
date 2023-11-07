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
    int wordLimit() {
      var width = MediaQuery.of(context).size.width;

      if (width < 500) {
        return 20;
      } else if (width < 550) {
        return 25;
      } else if (width < 600) {
        return 30;
      }

      return 70;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding / 2),
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
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
                      compressString(movimento.descricao, wordLimit()),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bebida & Comida',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tipoMovimentoId == 1
                      ? numberFormat.format(600000)
                      : '- ${numberFormat.format(valor)}',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: tipoMovimentoId == 1
                        ? kVerdeAccentColor
                        : kVermelhaColor,
                  ),
                ),
                Text(
                  movimento.data.day == DateTime.now().day
                      ? 'Hoje ${DateFormat('hh:mm').format(movimento.data)}'
                      : dateFormat.format(movimento.data),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

            // if (!movimento.confirmado)
            //   Icon(
            //     CupertinoIcons.exclamationmark_triangle_fill,
            //     size: 30,
            //     weight: 1,
            //     color: tipoMovimentoId == 1 ? kVerdeColor : kVermelhaColor,
            //   ),
            // Gutter(),


                    
                    // Text(
                    //   tipoMovimentoId == 1
                    //       ? numberFormat.format(valor)
                    //       : '- ${numberFormat.format(valor)}',
                    //   style: GoogleFonts.inter(
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.bold,
                    //     color: tipoMovimentoId == 1
                    //         ? kVerdeAccentColor
                    //         : kVermelhaColor,
                    //   ),
                    // ),