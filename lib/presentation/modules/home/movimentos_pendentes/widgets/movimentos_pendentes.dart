// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/movimentos_pendentes.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/widgets/movimentos_pendentes_item.dart';
import 'package:flutter/material.dart';

class ListMovimentosPendentes extends StatelessWidget {
  const ListMovimentosPendentes({
    super.key,
    required this.movimentosPendentes,
  });

  final List<MovimentosPendentes> movimentosPendentes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kDefaultPadding),
      child: ListView.builder(
        itemBuilder: (_, index) {
          return FontReceitaListItem(
            movimento: movimentosPendentes[index],
          );
        },
        itemCount: movimentosPendentes.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

}
