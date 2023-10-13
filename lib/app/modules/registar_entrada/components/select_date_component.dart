import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import '../controllers/registar_entrada_controller.dart';

class SelectDateComponent extends StatelessWidget {
  const SelectDateComponent({
    super.key,
    required this.controller,
  });

  final RegistarEntradaController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder(
          init: controller,
          builder: (context) {
            return Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: controller.getSelectedDate(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          },
        ),
        const Gutter(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Get.theme.colorScheme.surfaceTint.withOpacity(.1),
          ),
          onPressed: () {
            controller.selecionarDateTime(context);
          },
          child: const Text('Selecionar data'),
        ),
      ],
    );
  }
}
