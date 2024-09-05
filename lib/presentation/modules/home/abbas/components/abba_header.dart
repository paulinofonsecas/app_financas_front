// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AbbaHeader extends StatelessWidget {
  const AbbaHeader({
    super.key,
    required this.title,
    this.verMaisAction,
  });

  final String title;
  final GestureTapCallback? verMaisAction;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: theme.titleMedium!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (verMaisAction != null)
          GestureDetector(
            onTap: verMaisAction,
            child: Text(
              'Ver mais',
              style: GoogleFonts.inter(
                fontSize: theme.titleMedium!.fontSize,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
      ],
    );
  }
}
