// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import 'categoria_item_component.dart';

class CategoriaListComponent extends StatelessWidget {
  const CategoriaListComponent({
    Key? key,
    required this.categorias,
    required this.selectedCategoriaId,
  }) : super(key: key);

  final List<Categoria> categorias;
  final int selectedCategoriaId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (c, i) {
        var categoria = categorias[i];

        return CategoriaItem(
          onTap: () {
            Navigator.of(context).pop(categoria);
          },
          categoria: categoria,
          isSelected: categoria.id == selectedCategoriaId,
        );
      },
    );
  }
}
