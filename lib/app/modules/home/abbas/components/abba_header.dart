// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AbbaHeader extends StatelessWidget {
  const AbbaHeader({
    Key? key,
    required this.title,
    this.verMaisAction,
  }) : super(key: key);

  final String title;
  final GestureTapCallback? verMaisAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: verMaisAction,
          child: Text(
            'Ver mais',
            style: GoogleFonts.inter(
              fontSize: 22,
              color: kAzulColor,
            ),
          ),
        ),
      ],
    );
  }
}
