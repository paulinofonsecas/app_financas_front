import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saldo disponivel',
          style: GoogleFonts.inter(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        Text(
          'Kz 650.000,00',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
