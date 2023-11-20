// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import 'components/categoria_list_component.dart';
import 'components/search_component.dart';
import 'components/bottom_category_comp_controller.dart';

class BottomCategoryComponent extends StatefulWidget {
  const BottomCategoryComponent({
    Key? key,
    required this.tipoCategoria,
    required this.selectedCategoriaId,
  }) : super(key: key);

  final TipoCategoria tipoCategoria;
  final int selectedCategoriaId;

  static Future<dynamic> openModalBottomSheet(
    BuildContext context,
    TipoCategoria tipoCategoria,
    int selectedCategoriaId,
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
        return BottomCategoryComponent(
          tipoCategoria: tipoCategoria,
          selectedCategoriaId: selectedCategoriaId,
        );
      },
    );
  }

  @override
  State<BottomCategoryComponent> createState() =>
      _BottomCategoryComponentState();
}

class _BottomCategoryComponentState extends State<BottomCategoryComponent> {
  late final BottomCategoryCompController controller;

  @override
  void initState() {
    controller = Get.put(
      BottomCategoryCompController(tipoCategoria: widget.tipoCategoria),
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
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: SearchComponent(),
          ),
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

                    return CategoriaListComponent(
                      categorias: categorias,
                      selectedCategoriaId: widget.selectedCategoriaId,
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
