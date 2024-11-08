import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/item_planejamento_list_item.dart';
import 'package:flutter/material.dart';

class CategoriasPlanejamentoSection extends StatelessWidget {
  const CategoriasPlanejamentoSection({super.key, required this.planejamento});

  final Planejamento planejamento;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: planejamento.itens
          .map((e) => ItemPlanejamentoListItem(itemPlanejamento: e))
          .toList(),
    );
  }
}
