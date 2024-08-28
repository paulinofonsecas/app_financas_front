// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/components/not_confirm_widget_indicator.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/helders/string_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovimentoItem extends StatelessWidget {
  const MovimentoItem({
    super.key,
    required this.movimento,
    required this.asset,
    required this.title,
    required this.conta,
    required this.valor,
    required this.avatarBgColor,
    required this.tipoMovimentoId,
    this.onTap,
  });

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
    var width = MediaQuery.of(context).size.width;
    int wordLimit() {
      if (width < 500) {
        return 20;
      } else if (width > 550 && width < 6000) {
        return 25;
      } else if (width > 600) {
        return 30;
      }

      return 70;
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              height: 64,
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
                // vertical: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: movimento.categoria?.color ??
                            kBlackColor.withOpacity(.5),
                        radius: 15,
                        child: Center(
                          child: Icon(
                            movimento.categoria?.icon ?? Icons.more_horiz,
                            color: Colors.white,
                            size: 15,
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
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            movimento.categoria?.name ?? '',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  if (width > 300) buildMovimentoDetails()
                ],
              ),
            ),
            if (!movimento.confirmado) NotConfirmWidgetIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildMovimentoDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tipoMovimentoId == 1
              ? numberFormat.format(valor)
              : '- ${numberFormat.format(valor)}',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: tipoMovimentoId == 1 ? kVerdeAccentColor : kVermelhaColor,
          ),
        ),
        Text(
          movimento.data.day == DateTime.now().day
              ? 'Hoje ${DateFormat('hh:mm').format(movimento.data)}'
              : dateFormat.format(movimento.data),
          style: GoogleFonts.inter(
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}
