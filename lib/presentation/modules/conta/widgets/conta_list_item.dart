import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContaListItem extends StatelessWidget {
  const ContaListItem({super.key, required this.conta});

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        conta.iconAsset != null
            ? SvgPicture.asset('teste')
            : const Icon(
                Icons.money,
              ),
        Column(
          children: [
            Text(
              conta.nome,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Saldo atual',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Saldo previsto',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ],
    );
  }
}
