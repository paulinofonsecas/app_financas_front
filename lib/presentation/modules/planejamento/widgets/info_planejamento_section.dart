import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/usage_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class InfoPlanejamentoSection extends StatelessWidget {
  const InfoPlanejamentoSection({super.key, required this.planejamento});

  final Planejamento planejamento;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            DuetInfo(
              title: 'Total planejado: ',
              valor: planejamento.plafound,
            ),
            DuetInfo(
              title: 'Resta: ',
              valor: planejamento.restante,
            ),
            const Gutter(),
            UsageProgress(
              finalValue: planejamento.plafound,
              actualValue: planejamento.totalGasto,
              color: null,
            ),
            const GutterSmall(),
          ],
        ),
      ),
    );
  }
}

class DuetInfo extends StatelessWidget {
  const DuetInfo({super.key, required this.title, required this.valor});

  final String title;
  final double valor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
        const GutterTiny(),
        Text(
          numberFormat.format(valor),
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
