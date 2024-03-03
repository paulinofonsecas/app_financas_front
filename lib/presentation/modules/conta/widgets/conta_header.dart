import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContaHeader extends StatelessWidget {
  const ContaHeader({
    super.key,
    this.defaultColor = Colors.white,
    required this.title,
    this.trailing,
  });

  final Color defaultColor;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              foregroundColor: defaultColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.chevron_left),
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              color: defaultColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          if (trailing != null)
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: defaultColor,
              ),
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            )
        ],
      ),
    );
  }
}
