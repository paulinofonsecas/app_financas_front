// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta_list_item.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'conta_list_header_widget.dart';

class ContaListSection extends StatelessWidget {
  const ContaListSection({
    Key? key,
    required this.contas,
  }) : super(key: key);

  final List<Conta> contas;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ContaListHeaderWidget(),
        const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
        const GutterTiny(),
        Expanded(
          child: ListView.separated(
            itemCount: contas.length,
            separatorBuilder: (context, index) => const GutterSmall(),
            itemBuilder: (context, index) =>
                ContaListItem(conta: contas[index]),
          ),
        ),
      ],
    );
  }
}
