import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonGoToCarteira extends StatelessWidget {
  const ButtonGoToCarteira({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Carteira',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: kDefaultPadding / 2),
          Container(
            padding: const EdgeInsets.all(kDefaultPadding / 1.7),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kWhiteColor,
            ),
            child: const Icon(
              CupertinoIcons.arrow_right,
            ),
          ),
        ],
      ),
    );
  }
}
