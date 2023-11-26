// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_financas/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultActionButton extends StatelessWidget {
  const DefaultActionButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2.8,
          vertical: kDefaultPadding / 1.5,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
