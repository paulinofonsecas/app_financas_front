import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFilter extends StatelessWidget {
  const MyTextFilter({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  final String title;
  final GestureTapCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
