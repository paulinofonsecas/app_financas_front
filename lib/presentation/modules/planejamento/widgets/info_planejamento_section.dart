import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/presentation/global/duet_info.dart';
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
              title: planejamento.restante < 0 ? 'Excedido: ' : 'Resta: ',
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
