import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/editar_categoria_controller.dart';

class NameTextFieldComp extends StatelessWidget {
  const NameTextFieldComp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditarCategoriaController>();

    return TextField(
      controller: controller.nameTextController,
      decoration: const InputDecoration(
        hintText: 'Nome',
        border: InputBorder.none,
      ),
    );
  }
}
