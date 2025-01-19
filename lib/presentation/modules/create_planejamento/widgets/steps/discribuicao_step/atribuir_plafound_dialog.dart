import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class AtribuirPlafoundDialog extends StatefulWidget {
  const AtribuirPlafoundDialog(
      {super.key, required this.plafound, required this.maxValue});

  final double plafound;
  final double maxValue;

  @override
  State<AtribuirPlafoundDialog> createState() => _AtribuirPlafoundDialogState();
}

class _AtribuirPlafoundDialogState extends State<AtribuirPlafoundDialog> {
  late final CurrencyTextFieldController controller;

  @override
  void initState() {
    super.initState();
    final locale = getIt<LocalizationCubit>().state.locale;

    controller = CurrencyTextFieldController(
      initDoubleValue: widget.plafound,
      maxValue: widget.maxValue,
      minValue: 0.0,
      currencySymbol: locale.currencySymbol,
      decimalSymbol: ",",
      thousandSymbol: ".",
      currencyOnLeft: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atribuir Plafound'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Quanto deseja atribuir a essa categoria?'),
          const Gutter(),
          TextField(
            autofocus: true,
            controller: controller,
            textAlign: TextAlign.center,
            inputFormatters: const [],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: numberFormat.format(0.00),
              hintStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              border: const UnderlineInputBorder(),
            ),
          ),
          const Gutter(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(controller.doubleValue);
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
