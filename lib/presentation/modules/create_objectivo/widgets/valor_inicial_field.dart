import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ValorInicialField extends StatelessWidget {
  const ValorInicialField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateObjectivoBloc>();
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      NumberFormat.currency(symbol: 'Kz'),
    );

    return Row(
      children: [
        const Icon(Icons.monetization_on),
        const GutterSmall(),
        Expanded(
          child: TextFormField(
            initialValue:
                formatter.formatDouble(bloc.objectivoModel.initialValue),
            onChanged: (v) {
              bloc.objectivoModel = bloc.objectivoModel.copyWith(
                initialValue: formatter.getDouble(),
              );
            },
            inputFormatters: <TextInputFormatter>[formatter],
            focusNode: FocusNode(canRequestFocus: true),
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              label: const Text('Valor inicial'),
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
