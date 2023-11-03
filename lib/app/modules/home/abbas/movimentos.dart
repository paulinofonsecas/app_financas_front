// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/app/components/movimento_item.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'package:app_financas/constants.dart';
import 'package:get/get.dart';

import '../../show_transaction/show_transaction_page.dart';
import 'components/abba_header.dart';

class MovimentosAtHomePage extends StatelessWidget {
  const MovimentosAtHomePage({
    super.key,
    required this.movimentos,
    required this.verMaisAction,
  });

  final List<Movimento> movimentos;
  final GestureTapCallback? verMaisAction;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomePageController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbbaHeader(
          title: 'Ultimos Movimentos',
          verMaisAction: verMaisAction,
        ),
        Gutter(),
        Column(
          children: movimentos
              .map(
                (movimento) => MovimentoItem(
                  onTap: () {
                    customShowModalBottomSheet(
                      context,
                      child: ShowTransactionPage(movimento: movimento),
                    ).then((value) => controller.update(['geral']));
                  },
                  movimento: movimento,
                  asset: 'assets/svgs/categories/desktop.svg',
                  title: movimento.descricao,
                  conta: 'Tecnologia',
                  valor: movimento.valor,
                  tipoMovimentoId: movimento.tipoMovimentoId,
                  avatarBgColor: kAmarelhoColor,
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
