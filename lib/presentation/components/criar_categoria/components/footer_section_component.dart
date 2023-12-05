import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/criar_categoria_controller.dart';

class FooterSectionComponent extends StatelessWidget {
  const FooterSectionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CriarCategoriaController>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DefaultActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.purple,
              width: 2,
            ),
            backgroundColor: Colors.transparent,
          ),
          foregroundColor: Colors.purple,
          text: 'Cancelar',
        ),
        DefaultActionButton(
          onPressed: () {
            controller.cadastrarCategoria().then((value) {
              Navigator.of(context).pop();
            });
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.purple,
              width: 2,
            ),
            backgroundColor: Colors.purple,
          ),
          text: 'Salvar',
        ),
      ],
    );
  }
}
