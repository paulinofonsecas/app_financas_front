import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultMoneyTextField extends StatelessWidget {
  const DefaultMoneyTextField({
    super.key,
    this.onChanged,
    required this.controller,
  });

  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      focusNode: FocusNode(canRequestFocus: true),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      style: GoogleFonts.inter(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: '0,00',
        hintStyle: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        prefixText: 'Kz ',
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
      ),
    );
  }
}
