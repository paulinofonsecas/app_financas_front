// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/app/components/categoria_bottom_components/bottom_category_component.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/helders/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 24),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Get.theme.iconTheme.color,
            ),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              BottomCategoryComponent.openModalBottomSheet(
                context,
                TipoCategoria.entrada,
                2,
              );
            },
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Olá, bom dia',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Kwanza Gest',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(),
          // Cupertino alert icons
          IconButton(
            onPressed: () {
              Get.isDarkMode
                  ? Get.changeTheme(ThemeData.light(useMaterial3: true))
                  : Get.changeTheme(ThemeData.dark(useMaterial3: true));
            },
            icon: Icon(
              isDarkMode(context) ? Icons.nightlight_round : Icons.wb_sunny,
              color: Get.theme.iconTheme.color,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
