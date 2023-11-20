import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandedInfo extends StatelessWidget {
  const ExpandedInfo({
    super.key,
    required this.desc,
    required this.value,
    required this.icon,
  });

  final String desc;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          desc,
          style: GoogleFonts.inter(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value.isEmpty ? 'Nenhuma' : value,
          softWrap: true,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
