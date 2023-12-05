import 'package:flutter/material.dart';

import 'package:app_financas/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultActionButton extends StatelessWidget {
  const DefaultActionButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  final String text;
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: style ?? FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2.8,
          vertical: kDefaultPadding / 1.5,
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
