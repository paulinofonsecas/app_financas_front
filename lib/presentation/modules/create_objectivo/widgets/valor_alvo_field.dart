import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ValorAlvoField extends StatelessWidget {
  const ValorAlvoField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateObjectivoBloc>();
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      NumberFormat.currency(symbol: 'Kz'),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Valor do objetivo',
        ),
        TextFormField(
          initialValue: formatter.formatDouble(0),
          onChanged: (v) {
            if (v.isNotEmpty) {
              bloc.objectivoModel = bloc.objectivoModel.copyWith(
                targetValue: formatter.getDouble(),
              );
            }
          },
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
