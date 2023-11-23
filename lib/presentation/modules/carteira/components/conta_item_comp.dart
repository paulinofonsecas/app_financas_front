// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
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
            vertical: isActive ? 0 : kDefaultPadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
            gradient: isActive
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.inversePrimary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  )
                : null,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          numberFormat.format(conta.saldo),
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
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
              'Hoje, 08 Sept 2023',
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
