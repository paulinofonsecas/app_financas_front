// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageActionBar extends StatelessWidget {
  const PageActionBar({
    Key? key,
    required this.title,
    this.actionBack,
    this.rightWidget,
  }) : super(key: key);

  final String title;
  final GestureTapCallback? actionBack;
  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      child: Row(
        children: [
          IconButton(
            onPressed: actionBack,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.black,
              fontSize: 28,
            ),
          ),
          Spacer(),
          if (rightWidget != null) rightWidget!,
        ],
      ),
    );
  }
}
