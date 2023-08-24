// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EntradasESaidas extends StatelessWidget {
  const EntradasESaidas({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.1,
        decoration: BoxDecoration(
          color: kBlackColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: EntradaOuSaidaWidget(
                asset: 'assets/svgs/home_page/Arrow_down.svg',
                title: 'Entradas',
                valor: '53.000',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: VerticalDivider(),
            ),
            Expanded(
              child: EntradaOuSaidaWidget(
                asset: 'assets/svgs/home_page/Arrow_up.svg',
                title: 'Saida',
                valor: '150.000',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EntradaOuSaidaWidget extends StatelessWidget {
  const EntradaOuSaidaWidget({
    super.key,
    required this.asset,
    required this.title,
    required this.valor,
  });

  final String asset;
  final String title;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(asset),
        SizedBox(width: kDefaultPadding),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Text(
              'Kz $valor',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
