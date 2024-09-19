import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/presentation/modules/objectivos/bottom_sheets/widgets/fundo_field.dart';
import 'package:app_financas/presentation/modules/objectivos/cubit/adicionar_fundos_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class AddFundosBody extends StatelessWidget {
  const AddFundosBody({
    super.key,
    required this.formatterState,
    required this.formKey,
    required this.objectivo,
  });

  final ValueNotifier<CurrencyTextInputFormatter> formatterState;
  final ValueNotifier<GlobalKey<FormState>> formKey;
  final Objectivo objectivo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FundoField(formatter: formatterState.value),
        const Gutter(),
        const GutterLarge(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            const Gutter(),
            FilledButton(
              onPressed: () {
                if (formKey.value.currentState!.validate()) {
                  context.read<AdicionarFundosCubit>().adicionarFundos(
                        objectivo,
                        formatterState.value.getDouble(),
                      );
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ],
    );
  }
}
