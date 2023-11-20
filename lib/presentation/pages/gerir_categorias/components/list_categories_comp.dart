// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/presentation/widgets/editar_categoria/editar_categoria_component.dart';
import 'package:app_financas/presentation/pages/gerir_categorias/controllers/gerir_categoria_controller.dart';
import 'package:app_financas/presentation/helders/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

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

  CategoriaItem _buildCategoriaItem(Categoria categoria, BuildContext context,
      GerirCategoriaController controller) {
    return CategoriaItem(
      categoria: categoria,
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

class CategoriaItem extends StatelessWidget {
  const CategoriaItem({
    Key? key,
    required this.categoria,
    this.onTap,
    this.onActionTap,
  }) : super(key: key);

  final Categoria categoria;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 4,
        ),
        title: Text(
          categoria.name.capitalize.toString(),
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            // color: Colors.black,
          ),
        ),
        leading: CircleAvatar(
          backgroundColor: categoria.color ?? Colors.purple,
          child: Icon(
            categoria.icon ?? Icons.icecream,
            color: Colors.white,
            size: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onActionTap,
              icon: Icon(
                CupertinoIcons.archivebox,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
