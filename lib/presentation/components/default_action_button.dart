import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultActionButton extends StatelessWidget {
  const DefaultActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String text;
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: style ??
          OutlinedButton.styleFrom(
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
