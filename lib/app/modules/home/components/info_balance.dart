import 'package:app_financas/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({super.key, required this.saldo});

  final double saldo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saldo disponivel',
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const Gutter(),
        Text(
          numberFormat.format(saldo),
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
