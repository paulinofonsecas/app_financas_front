// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/app/components/movimento_item.dart';
import 'package:app_financas/app/modules/show_despesa_transaction/controller/show_despesa_transaction_controller.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'package:app_financas/constants.dart';
import 'package:get/get.dart';

import '../../show_despesa_transaction/show_despesa_transaction_page.dart';
import '../../show_receita_transaction/show_incomming_transaction_page.dart';
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
                      child: movimento.tipoMovimentoId == 1
                          ? ShowIncomingTransactionPage(movimento: movimento)
                          : ShowDespesaTransactionPage(movimento: movimento),
                    ).then((value) {
                      Get.delete(
                          tag: 'ShowDespesaTransactionController', force: true);
                      Get.delete(
                          tag: 'ShowReceitaTransactionController', force: true);
                    });
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
