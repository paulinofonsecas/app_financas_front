// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/components/bottom_sheet_contas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/components/banco_img_widget.dart';

class ContaListItemComponent extends StatelessWidget {
  const ContaListItemComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomSheetContasWidget.openModalBottomSheet(context);
      },
      child: Row(
        children: [
          _ShowContaWidget(
            conta: Conta.fake(),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _ShowContaWidget extends StatelessWidget {
  const _ShowContaWidget({
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2.3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        border: Border.all(
          color: conta.color,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          conta.banco.imgAsset != null && conta.banco.imgAsset!.isNotEmpty
              ? BancoImgCircularWidget(conta: conta)
              : const Icon(
                  FontAwesomeIcons.buildingColumns,
                  size: 18,
                ),
          const GutterSmall(),
          Text(conta.nome),
        ],
      ),
    );
  }
}
