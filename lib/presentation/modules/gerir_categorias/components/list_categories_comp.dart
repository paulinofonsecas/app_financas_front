// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/presentation/components/editar_categoria/editar_categoria_component.dart';
import 'package:app_financas/presentation/modules/gerir_categorias/components/categoria_item.dart';
import 'package:app_financas/presentation/modules/gerir_categorias/controllers/gerir_categoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCategoriesComp extends StatelessWidget {
  const ListCategoriesComp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GerirCategoriaController>();

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: GetBuilder(
          init: controller,
          id: 'geral',
          builder: (c) {
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

                return ListView.builder(
                  itemCount: categorias.length,
                  itemBuilder: (c, i) {
                    var categoria = categorias[i];

                    return _buildCategoriaItem(categoria, context, controller);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  CategoriaItem _buildCategoriaItem(
    Categoria categoria,
    BuildContext context,
    GerirCategoriaController controller,
  ) {
    return CategoriaItem(
      categoria: categoria,
      tipoCategoria: controller.tipoCategoria,
      onTap: () {
        EditarCategoriaComponent.openModalBottomSheet(
          context: context,
          tipoCategoria: controller.tipoCategoria,
          categoria: categoria,
        ).then((value) {
          controller.update(['geral']);
        });
      },
      onActionTap: () {
        Get.defaultDialog(
          title: 'Arquivar categoria',
          content: Text(
            'Deseja realmente arquivar\n a categoria ${categoria.name}?',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: kVerdeAccentColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: kVermelhaAccentColor,
              ),
              onPressed: () {
                controller.arquivarCategoria(categoria.id).then(
                  (value) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                );
              },
              child: const Text('Arquivar'),
            ),
          ],
        );
      },
    );
  }
}
