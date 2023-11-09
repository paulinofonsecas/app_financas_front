import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import '../controllers/editar_categoria_controller.dart';
import 'icon_item_comp.dart';
import 'select_outros_icons_comp.dart';

class IconPickerList extends StatelessWidget {
  const IconPickerList({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditarCategoriaController>();

    return GetBuilder(
      init: controller,
      id: 'icon',
      builder: (context) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconItemComponent(
              color: controller.selectedColor,
              isSelected: controller.selectedIconIndex == 0,
              icon: controller.icons[0],
              onTap: () {
                controller.setSelectedIconIndex(0);
              },
            ),
            const Gutter(),
            IconItemComponent(
              color: controller.selectedColor,
              isSelected: controller.selectedIconIndex == 1,
              icon: controller.icons[1],
              onTap: () {
                controller.setSelectedIconIndex(1);
              },
            ),
            const Gutter(),
            IconItemComponent(
              color: controller.selectedColor,
              isSelected: controller.selectedIconIndex == 2,
              icon: controller.icons[2],
              onTap: () {
                controller.setSelectedIconIndex(2);
              },
            ),
            const Gutter(),
            const Expanded(child: SelectOutrosIconsComponent()),
            const GutterLarge(),
          ],
        );
      },
    );
  }
}
