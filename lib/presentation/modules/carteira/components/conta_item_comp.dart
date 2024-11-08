// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/presentation/components/banco_img_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';

class ContaItem extends StatelessWidget {
  const ContaItem({
    Key? key,
    required this.conta,
    required this.isActive,
    this.onTap,
  }) : super(key: key);

  final Conta conta;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2,
            vertical: isActive ? 10 : kDefaultPadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: !isActive
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.secondaryContainer,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.shadow.withOpacity(.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                      spreadRadius: 1,
                    ),
                  ]
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerSection(),
                Spacer(),
                bottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          numberFormat.format(conta.saldo),
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            if (conta.banco.imgAsset != null)
              BancoImgCircularWidget(conta: conta),
            const GutterTiny(),
            Text(
              conta.banco.acronimo ?? '',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row headerSection() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conta.nome,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              conta.banco.nome,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

