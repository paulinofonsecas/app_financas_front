import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class PlafoundStep extends StatefulWidget {
  const PlafoundStep({super.key});

  @override
  State<PlafoundStep> createState() => _PlafoundStepState();
}

class _PlafoundStepState extends State<PlafoundStep> {
  var controller = CurrencyTextFieldController(
    currencySymbol: "Kz",
    decimalSymbol: ",",
    thousandSymbol: ".",
    currencyOnLeft: false,
  );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      context
          .read<CreatePlanejamentoCubit>()
          .updatePlafound(controller.doubleValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Vamos orçar! Começe nos dizendo qual é a sua receita mensal total.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gutter(),
        TextField(
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
      ],
    );
  }
}
