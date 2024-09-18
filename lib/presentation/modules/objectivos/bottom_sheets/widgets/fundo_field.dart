import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FundoField extends StatelessWidget {
  const FundoField({super.key, required this.formatter});

  final CurrencyTextInputFormatter formatter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Valor',
        ),
        TextFormField(
          initialValue: formatter.formatDouble(0),
          validator: (v) {
            if (v == null || v.isEmpty || formatter.getDouble() <= 0) {
              return 'Valor obrigatório';
            }
            return null;
          },
          inputFormatters: <TextInputFormatter>[formatter],
          focusNode: FocusNode(canRequestFocus: true),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
