import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'conta_list_header_widget.dart';
import 'conta_list_section.dart';

/// {@template conta_body}
/// Body of the ContaPage.
///
/// Add what it does
/// {@endtemplate}
class ContaBody extends StatelessWidget {
  /// {@macro conta_body}
  const ContaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Column(
            children: [
              ContaListHeaderWidget(),
              Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
              GutterTiny(),
              Expanded(child: ContaListSection()),
            ],
          ),
        ),
      ),
    );
  }
}
