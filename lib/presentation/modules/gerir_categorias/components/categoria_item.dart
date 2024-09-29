// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/view/criar_sub_categoria_page.dart';
import 'package:app_financas/presentation/modules/gerir_categorias/components/sub_categoria_item.dart';
import 'package:app_financas/presentation/modules/gerir_categorias/controllers/gerir_categoria_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriaItem extends StatelessWidget {
  const CategoriaItem({
    super.key,
    required this.categoria,
    this.onTap,
    this.onActionTap,
    required this.tipoCategoria,
  });

  final TipoCategoria tipoCategoria;
  final Categoria categoria;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: kDefaultPadding,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 4,
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              CategoriaListItem(
                categoria: categoria,
                onTap: onTap,
                onActionTap: onActionTap,
                tipoCategoria: tipoCategoria,
              ),
              if (categoria.subCategorias.isNotEmpty) ...[
                Gutter(),
                ...(categoria.subCategorias
                      ..sort((a, b) => a.name.compareTo(b.name)))
                    .map((e) => SubCategoriaItem(subCategoria: e))
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriaListItem extends StatelessWidget {
  const CategoriaListItem({
    super.key,
    required this.categoria,
    this.onTap,
    this.onActionTap,
    required this.tipoCategoria,
  });

  final TipoCategoria tipoCategoria;
  final Categoria categoria;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GerirCategoriaController>();

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: categoria.color ?? Colors.purple,
          child: Icon(
            categoria.icon ?? Icons.icecream,
            color: Colors.white,
            size: 16,
          ),
        ),
        Gutter(),
        Text(
          categoria.name.capitalize.toString(),
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                CriarSubCategoriaPage.show(
                  context,
                  categoria,
                  tipoCategoria,
                ).then(
                  (value) {
                    controller.update(['geral']);
                  },
                );
              },
              icon: Icon(
                CupertinoIcons.add_circled,
                color: Colors.grey[500],
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gutter(),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            onTap?.call();
                          },
                          title: Center(child: Text('Editar')),
                          titleAlignment: ListTileTitleAlignment.center,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            onActionTap?.call();
                          },
                          title: Center(child: Text('Arquivar')),
                          titleAlignment: ListTileTitleAlignment.center,
                        ),
                        Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: Center(
                            child: Text('Cancelar'),
                          ),
                          titleAlignment: ListTileTitleAlignment.center,
                        ),
                        GutterLarge(),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.more_horiz,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
