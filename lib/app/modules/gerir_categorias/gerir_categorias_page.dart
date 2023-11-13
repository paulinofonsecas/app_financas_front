// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import '../../components/criar_categoria/criar_categoria_component.dart';
import 'components/header_comp.dart';
import 'components/list_categories_comp.dart';
import 'components/tipo_categoria_switch_comp.dart';
import 'controllers/gerir_categoria_controller.dart';

class GerirCategoriasPage extends StatefulWidget {
  const GerirCategoriasPage({
    Key? key,
    required this.tipoCategoria,
  }) : super(key: key);

  final TipoCategoria tipoCategoria;

  @override
  State<GerirCategoriasPage> createState() => _GerirCategoriasPageState();
}

class _GerirCategoriasPageState extends State<GerirCategoriasPage> {
  late final GerirCategoriaController controller;

  @override
  void initState() {
    controller = Get.put(
      GerirCategoriaController(tipoCategoria: widget.tipoCategoria),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: 'geral',
      builder: (c) {
        return Scaffold(
          backgroundColor: c.tipoCategoria == TipoCategoria.entrada
              ? kVerdeAccentColor
              : kVermelhaColor,
          body: const SafeArea(
            child: Column(
              children: [
                HeaderComp(),
                Gutter(),
                TipoCategoriaSwitchComp(),
                GutterLarge(),
                ListCategoriesComp(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: c.tipoCategoria == TipoCategoria.entrada
                ? kVerdeAccentColor
                : kVermelhaColor,
            onPressed: () {
              CriarCategoriaComponent.openModalBottomSheet(
                context: context,
                tipoCategoria: c.tipoCategoria,
              ).then((value) {
                controller.update(['geral']);
              });
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
