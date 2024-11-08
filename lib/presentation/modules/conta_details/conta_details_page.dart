// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:app_financas/presentation/components/movimento_item.dart';
import 'package:app_financas/presentation/modules/carteira/components/my_text_filter.dart';
import 'package:app_financas/presentation/modules/conta_details/components/card_section_comp.dart';
import 'package:app_financas/presentation/modules/conta_details/controllers/conta_details_page_controller.dart';
import 'package:app_financas/presentation/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/entities/tipo_movimento.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContaDetailsPage extends StatefulWidget {
  const ContaDetailsPage({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  State<ContaDetailsPage> createState() => _ContaDetailsPageState();
}

class _ContaDetailsPageState extends State<ContaDetailsPage> {
  late final ContaDetailsPageController controller;

  @override
  initState() {
    controller = Get.put(ContaDetailsPageController(conta: widget.conta));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: GetBuilder(
          init: controller,
          id: 'geral',
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardSection(conta: controller.conta),
                movimentoSection(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget headerMovimentoSection() {
    return Material(
      child: Hero(
        tag: 'header_movimento',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFilter(
                title: 'Tudo',
                isActive: true,
                onTap: () {
                  controller.changeESFilter(0);
                },
              ),
              const GutterTiny(),
              MyTextFilter(
                title: 'Saídas',
                isActive: false,
                onTap: () {
                  controller.changeESFilter(TipoMovimento.SAIDA);
                },
              ),
              const GutterTiny(),
              MyTextFilter(
                title: 'Entrada',
                isActive: false,
                onTap: () {
                  controller.changeESFilter(TipoMovimento.ENTRADA);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget movimentoSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerMovimentoSection(),
            const GutterTiny(),
            Expanded(
              child: PagedListView<int, Movimento>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movimento>(
                  itemBuilder: (context, movimento, index) => MovimentoItem(
                    movimento: movimento,
                    asset: 'assets/svgs/categories/desktop.svg',
                    title: movimento.descricao,
                    conta: 'Tecnologia',
                    valor: movimento.valor,
                    tipoMovimentoId: movimento.tipoMovimentoId,
                    avatarBgColor: kAmarelhoColor,
                    onTap: () {
                      if (movimento.categoriaMovimentoId == 303030) return;
                      if (movimento.categoriaMovimentoId == 303040) return;

                      customShowModalBottomSheet(
                        context,
                        child: ShowTransactionPage(
                          movimento: movimento,
                          onEdit: () {
                            controller.updateGeral();
                          },
                          onConfirmar: () {
                            controller.updateGeral();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
