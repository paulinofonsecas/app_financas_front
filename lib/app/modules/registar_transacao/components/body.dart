// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/app/components/my_divider.dart';
import 'package:app_financas/app/components/with_icon.dart';
import 'package:app_financas/app/modules/registar_transacao/components/select_date_component.dart';
import 'package:app_financas/app/modules/registar_transacao/controllers/registar_transacao_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/helders/helpers.dart';

import 'category_list_item_component.dart';
import 'register_despesa_header.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    this.contaId,
  }) : super(key: key);

  final int? contaId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Get.find<RegistarTransacaoController>();
    if (contaId != null) controller.cartaoId = contaId!;

    return SingleChildScrollView(
      child: Column(
        children: [
          const RegisterHeader(),
          Container(
            constraints: BoxConstraints(
              minHeight: size.height * .9,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const GutterLarge(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle_outlined),
                          const Gutter(),
                          Text(isReceita(controller.movimentoType)
                              ? 'Recebido'
                              : 'Pago'),
                          const Spacer(),
                          Obx(
                            () => Switch(
                              value: controller.confirmado.value,
                              onChanged: (c) {
                                if (controller.date.isAfter(DateTime.now())) {
                                  controller.confirmado.value = false;
                                  showErrorMessage(
                                    'Impossível confirmar',
                                    'Aguarde até a data selecionada para confirmar '
                                        'a ${isReceita(controller.movimentoType) ? 'receita' : 'despesa'} '
                                        'ou selecione uma data igual ou inferior a de hoje.',
                                    duration: const Duration(seconds: 7),
                                    backgroundColor: Colors.orange[700],
                                  );
                                } else {
                                  controller.confirmado.value = c;
                                }
                              },
                              activeColor: Colors.white,
                              activeTrackColor:
                                  isReceita(controller.movimentoType)
                                      ? kVerdeForteColor
                                      : kVermelhaForteColor,
                            ),
                          ),
                        ],
                      ),
                      const GutterTiny(),
                      const MyDivider(),
                      const GutterTiny(),
                      const WithIcon(
                        icon: Icons.calendar_today_outlined,
                        child: SelectDateComponent(),
                      ),
                      const GutterTiny(),
                      const MyDivider(),
                      const GutterTiny(),
                      WithIcon(
                        icon: Icons.create_rounded,
                        child: TextField(
                          controller: controller.descricaoTextController,
                          decoration: const InputDecoration(
                            hintText: 'Descrição',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      const GutterTiny(),
                      const MyDivider(),
                      const GutterSmall(),
                      const WithIcon(
                        icon: Icons.label_outline,
                        child: CategoryListItemComponent(),
                      ),
                      const GutterSmall(),
                      const MyDivider(),
                      const GutterTiny(),
                      WithIcon(
                        icon: Icons.wallet_outlined,
                        child: GetBuilder(
                          id: 'conta',
                          init: controller,
                          builder: (context) {
                            return DropdownButton<int>(
                              value: controller.cartaoId,
                              isExpanded: true,
                              onChanged: (int? value) {
                                if (value == null) {
                                  return;
                                }
                                controller.cartaoId = value;
                                controller.update(['conta']);
                              },
                              borderRadius: BorderRadius.circular(8),
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 4),
                              hint: const Text('Conta'),
                              items: controller
                                  .getCards()
                                  .map((c) => DropdownMenuItem(
                                        value: c.id,
                                        child: Text(c.nome),
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                      ),
                      const GutterTiny(),
                      const MyDivider(),
                      const GutterTiny(),
                      WithIcon(
                        icon: Icons.create_outlined,
                        child: TextField(
                          controller: controller.obsTextController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            hintText: 'Observações',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const GutterTiny(),
                      const MyDivider(),
                      const GutterLarge(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
