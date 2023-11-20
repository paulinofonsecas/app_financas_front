// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/presentation/helders/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import '../../editar_categoria/editar_categoria_component.dart';
import '../controllers/archived_bottom_category_controller.dart';
import 'archived_categoria_item_component.dart';

class CategoriaArchivedListComponent extends StatelessWidget {
  const CategoriaArchivedListComponent({
    Key? key,
    required this.categorias,
    required this.tipoCategoria,
  }) : super(key: key);

  final List<Categoria> categorias;
  final TipoCategoria tipoCategoria;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BottomCategoryArchivedController>();

    return GetBuilder(
        init: controller,
        id: 'categoriaList',
        builder: (c) {
          return ListView(
            children: [
              ...List.generate(categorias.length, (i) {
                var categoria = categorias[i];

                return ArchivedCategoriaItem(
                  onTap: () {
                    EditarCategoriaComponent.openModalBottomSheet(
                      context: context,
                      tipoCategoria: controller.tipoCategoria,
                      categoria: categoria,
                    ).then((value) {
                      controller.update(['geral', 'categoriaList']);
                    });
                  },
                  onIconTap: () async {
                    await controller.desarquivarCategoria(categoria.id);
                    Get.back();
                  },
                  categoria: categoria,
                );
              }).toList(),
            ],
          );
        });
  }
}

class CustomListTileAction extends StatelessWidget {
  const CustomListTileAction({
    Key? key,
    required this.title,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final String title;
  final GestureTapCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w400),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
