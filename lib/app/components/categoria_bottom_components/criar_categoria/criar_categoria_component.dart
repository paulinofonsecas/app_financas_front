// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/app/components/my_divider.dart';
import 'package:app_financas/app/components/with_icon.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/color_field_comp.dart';
import 'components/footer_section_component.dart';
import 'components/icon_field_comp.dart';
import 'components/name_text_field_comp.dart';
import 'controllers/criar_categoria_controller.dart';

class CriarCategoriaComponent extends StatefulWidget {
  const CriarCategoriaComponent({
    super.key,
    required this.tipoCategoria,
  });

  final TipoCategoria tipoCategoria;

  static Future<dynamic> openModalBottomSheet({
    required BuildContext context,
    required TipoCategoria tipoCategoria,
  }) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Get.theme.dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: false,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return CriarCategoriaComponent(
          tipoCategoria: tipoCategoria,
        );
      },
    );
  }

  @override
  State<CriarCategoriaComponent> createState() =>
      _CriarCategoriaComponentState();
}

class _CriarCategoriaComponentState extends State<CriarCategoriaComponent> {
  @override
  initState() {
    Get.put(CriarCategoriaController(
      tipoCategoria: widget.tipoCategoria,
    ));
    super.initState();
  }

  @override
  void dispose() {
    Get.find<CriarCategoriaController>().nameTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<CriarCategoriaController>()) {
      Get.replace(
        CriarCategoriaController(
          tipoCategoria: widget.tipoCategoria,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Criar categoria',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GutterLarge(),
          WithIcon(
            icon: Icons.description,
            color: Colors.grey,
            child: NameTextFieldComp(),
          ),
          MyDivider(),
          Gutter(),
          ColorFieldComp(),
          Gutter(),
          MyDivider(),
          GutterSmall(),
          IconFieldComp(),
          MyDivider(),
          GutterSmall(),
          Spacer(),
          FooterSectionComponent(),
        ],
      ),
    );
  }
}
