// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContaListHeaderWidget extends StatelessWidget {
  const ContaListHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kDefaultPadding / 4,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _HeaderItemWidget(
              icon: FontAwesomeIcons.coins,
              title: 'Total',
              value: 100000,
            ),
          ),
          Expanded(
            child: _HeaderItemWidget(
              icon: FontAwesomeIcons.dollarSign,
              title: 'Total até 30/NOV',
              value: 20000000,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderItemWidget extends StatelessWidget {
  const _HeaderItemWidget({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[800], size: 18),
        const GutterSmall(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              numberFormat.format(value),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kVerdeForteColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
