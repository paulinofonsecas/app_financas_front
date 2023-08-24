// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontesDeReceitaList extends StatelessWidget {
  const FontesDeReceitaList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return const FontReceitaListItem(
          bgColor: kVermelhaColor,
          name: 'ENDE',
          valor: 330000,
        );
      },
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );
  }
}

class FontReceitaListItem extends StatelessWidget {
  const FontReceitaListItem({
    Key? key,
    this.bgColor,
    required this.name,
    required this.valor,
  }) : super(key: key);

  final Color? bgColor;
  final String name;
  final double valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 130,
      decoration: BoxDecoration(
        color: bgColor ?? kVermelhaColor,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(right: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Center(
                child: Text(
                  name.substring(0, 1),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          const Spacer(),
          Column(
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                'Kz 350.000,00',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
