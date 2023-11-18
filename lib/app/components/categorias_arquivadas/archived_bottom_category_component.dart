// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'components/archived_categoria_list_component.dart';
import 'controllers/archived_bottom_category_controller.dart';

class BottomCategoryArchivedComponent extends StatefulWidget {
  const BottomCategoryArchivedComponent({
    Key? key,
    required this.tipoCategoria,
  }) : super(key: key);

  final TipoCategoria tipoCategoria;

  static Future<dynamic> openModalBottomSheet(
    BuildContext context,
    TipoCategoria tipoCategoria,
  ) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: true,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return BottomCategoryArchivedComponent(
          tipoCategoria: tipoCategoria,
        );
      },
    );
  }

  @override
  State<BottomCategoryArchivedComponent> createState() =>
      _BottomCategoryArchivedComponentState();
}

class _BottomCategoryArchivedComponentState
    extends State<BottomCategoryArchivedComponent> {
  late final BottomCategoryArchivedController controller;

  @override
  void initState() {
    controller = Get.put(
      BottomCategoryArchivedController(tipoCategoria: widget.tipoCategoria),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.changeTipoCategoria(widget.tipoCategoria);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Gutter(),
          Expanded(
            child: GetBuilder(
              init: controller,
              id: 'categoriaList',
              builder: (context) {
                return FutureBuilder<List<Categoria>>(
                  future: controller.getCategorias(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Ocorreu um erro ao buscar as categorias'),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var categorias = snapshot.data ?? [];

                    return CategoriaArchivedListComponent(
                      categorias: categorias,
                      tipoCategoria: widget.tipoCategoria,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
