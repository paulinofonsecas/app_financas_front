import 'package:app_financas/presentation/widgets/my_divider.dart';
import 'package:app_financas/presentation/widgets/with_icon.dart';
import 'package:app_financas/presentation/helders/constants.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import '../controllers/edit_transacao_controller.dart';
import 'category_list_item_component.dart';
import 'edit_transaction_header.dart';
import 'select_date_component.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller = Get.find<EditTransacaoController>();
    controller.init();

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
                                controller.confirmado.value = c;
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
                      const GutterTiny(),
                      const WithIcon(
                        icon: Icons.label_outline,
                        child: CategoryListItemComponent(),
                      ),
                      const GutterTiny(),
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
