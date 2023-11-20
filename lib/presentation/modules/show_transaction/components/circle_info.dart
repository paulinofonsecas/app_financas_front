import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleInfo extends StatelessWidget {
  const CircleInfo({
    super.key,
    required this.icon,
    required this.title,
    this.backgroundColor,
  });

  final Widget icon;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor ?? Colors.grey[500],
          radius: 22,
          child: Center(
            child: icon,
          ),
        ),
        const GutterTiny(),
        Text(
          title,
          style: GoogleFonts.inter(
            color: isDarkMode(context)
                ? Colors.white.withOpacity(.5)
                : Colors.grey[600],
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
