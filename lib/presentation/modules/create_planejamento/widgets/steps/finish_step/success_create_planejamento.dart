import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class SuccessCreatePlanejamento extends StatelessWidget {
  const SuccessCreatePlanejamento({super.key, required this.planejamento});

  final Planejamento planejamento;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }
}
