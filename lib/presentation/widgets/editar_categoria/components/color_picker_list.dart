import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import '../controllers/editar_categoria_controller.dart';
import 'color_item_comp.dart';
import 'select_outros_colors_comp.dart';

class ColorPickerList extends StatelessWidget {
  const ColorPickerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditarCategoriaController>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ColorItemComponent(
          color: controller.colors[0],
          isSelected: controller.selectedColorIndex == 0,
          onTap: () {
            controller.setSelectedColorIndex(0);
          },
        ),
        const Gutter(),
        ColorItemComponent(
          color: controller.colors[1],
          isSelected: controller.selectedColorIndex == 1,
          onTap: () {
            controller.setSelectedColorIndex(1);
          },
        ),
        const Gutter(),
        ColorItemComponent(
          color: controller.colors[2],
          isSelected: controller.selectedColorIndex == 2,
          onTap: () {
            controller.setSelectedColorIndex(2);
          },
        ),
        const Gutter(),
        const Expanded(child: SelectOutrosColorsComponent()),
        const GutterLarge(),
      ],
    );
  }
}
