// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/app/components/my_divider.dart';
import 'package:app_financas/app/components/with_icon.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import 'components/color_field_comp.dart';
import 'components/footer_section_component.dart';
import 'components/icon_field_comp.dart';
import 'components/name_text_field_comp.dart';
import 'controllers/editar_categoria_controller.dart';

class EditarCategoriaComponent extends StatefulWidget {
  const EditarCategoriaComponent({
    Key? key,
    required this.tipoCategoria,
    required this.categoria,
  }) : super(key: key);

  final TipoCategoria tipoCategoria;
  final Categoria categoria;

  static Future<dynamic> openModalBottomSheet({
    required BuildContext context,
    required TipoCategoria tipoCategoria,
    required Categoria categoria,
  }) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: false,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return EditarCategoriaComponent(
          tipoCategoria: tipoCategoria,
          categoria: categoria,
        );
      },
    );
  }

  @override
  State<EditarCategoriaComponent> createState() =>
      _EditarCategoriaComponentState();
}

class _EditarCategoriaComponentState extends State<EditarCategoriaComponent> {
  @override
  initState() {
    Get.put(EditarCategoriaController(
      tipoCategoria: widget.tipoCategoria,
      categoria: widget.categoria,
    ));
    super.initState();
  }

  @override
  void dispose() {
    Get.find<EditarCategoriaController>().nameTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<EditarCategoriaController>()) {
      Get.replace(
        EditarCategoriaController(
          tipoCategoria: widget.tipoCategoria,
          categoria: widget.categoria,
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
