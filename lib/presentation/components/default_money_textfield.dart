import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DefaultMoneyTextField extends StatelessWidget {
  const DefaultMoneyTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.textInputFormatter,
  });

  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputFormatter? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      focusNode: FocusNode(canRequestFocus: true),
      inputFormatters: [
        textInputFormatter ??
            CurrencyTextInputFormatter(
              NumberFormat.compactCurrency(symbol: 'Kz', decimalDigits: 2),
            )
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
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
      ),
    );
  }
}
