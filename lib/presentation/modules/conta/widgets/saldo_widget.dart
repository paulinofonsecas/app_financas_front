import 'package:app_financas/presentation/components/default_money_textfield.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/conta/cubit/saldo_inicial_text_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaldoWidget extends StatefulWidget {
  const SaldoWidget();

  @override
  State<SaldoWidget> createState() => _SaldoWidgetState();
}

class _SaldoWidgetState extends State<SaldoWidget> {
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter(numberFormat);

  @override
  Widget build(BuildContext context) {
    return DefaultMoneyTextField(
      onChanged: (value) {
        context
            .read<SaldoInicialTextCubit>()
            .onTextChange(_formatter.getUnformattedValue().toString());
      },
      textInputFormatter: _formatter,
    );
  }
}
