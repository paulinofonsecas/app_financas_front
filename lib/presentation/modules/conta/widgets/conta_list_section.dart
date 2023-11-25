// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta_list_item.dart';

class ContaListSection extends StatelessWidget {
  const ContaListSection({
    Key? key,
    required this.contas,
  }) : super(key: key);

  final List<Conta> contas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contas.length,
      itemBuilder: (context, index) => ContaListItem(conta: contas[index]),
    );
  }
}
