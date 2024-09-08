import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/item_planejamento.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/usage_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class ItemPlanejamentoListItem extends StatelessWidget {
  const ItemPlanejamentoListItem({super.key, required this.itemPlanejamento});

  final ItemPlanejamento itemPlanejamento;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderWidget(itemPlanejamento),
        const Gutter(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: UsageProgress(
            finalValue: itemPlanejamento.plafound,
            actualValue: itemPlanejamento.consumido,
            color: itemPlanejamento.categoria.color,
          ),
        ),
        const GutterLarge(),
        const Divider(),
      ],
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget(this.itemPlanejamento);

  final ItemPlanejamento itemPlanejamento;

  @override
  Widget build(BuildContext context) {
    final restante = itemPlanejamento.plafound - itemPlanejamento.consumido;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: itemPlanejamento.categoria.color,
          ),
          child: Icon(
            itemPlanejamento.categoria.icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        const Gutter(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemPlanejamento.categoria.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              restante < 0
                  ? 'Excedeu ${numberFormat.format(itemPlanejamento.consumido.abs())}'
                  : 'Restam ${numberFormat.format(restante)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: restante < 0
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
