import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class SuccessCreatePlanejamento extends StatelessWidget {
  const SuccessCreatePlanejamento({super.key, required this.planejamento});

  final Planejamento planejamento;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Parabens 🎉',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const Gutter(),
        Text(
          'Seu planejamento foi criado com sucesso!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const GutterLarge(),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(
              planejamento,
            );
          },
          child: const Text('Fechar'),
        )
      ],
    );
  }
}
