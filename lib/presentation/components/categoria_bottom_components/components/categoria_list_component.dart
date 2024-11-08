// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/my_divider.dart';
import 'package:app_financas/presentation/modules/gerir_categorias/gerir_categorias_page.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/listar_categoria_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../modules/registar_transacao/cubit/select_categoria_cubit.dart';
import '../../criar_categoria/criar_categoria_component.dart';
import 'bottom_category_comp_controller.dart';
import 'categoria_item_component.dart';

class CategoriaListComponent extends StatelessWidget {
  const CategoriaListComponent({
    super.key,
    required this.categorias,
    required this.selectedCategoriaId,
    required this.tipoCategoria,
  });

  final List<Categoria> categorias;
  final int? selectedCategoriaId;
  final TipoCategoria tipoCategoria;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BottomCategoryCompController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder(
          init: controller,
          id: 'categoriaList',
          builder: (c) {
            return ListView(
              children: [
                ...List.generate(categorias.length, (i) {
                  var categoria = categorias[i];

                  return CategoriaItem(
                    onTap: () {
                      controller.searchTextController.clear();
                      context
                          .read<SelectCategoriaCubit>()
                          .selectedCategoria(categoria);
                      Navigator.of(context).pop(categoria);
                    },
                    categoria: categoria,
                    isSelected: false,
                    selectedCategoriaId: selectedCategoriaId ?? -1,
                  );
                }),

                const Gutter(),
                const MyDivider(),
                const Gutter(),

                // listItem actions
                CustomListTileAction(
                  title: 'Criar categoria',
                  icon: Icons.add,
                  onTap: () {
                    CriarCategoriaComponent.openModalBottomSheet(
                      context: context,
                      tipoCategoria: tipoCategoria,
                    ).then((value) {
                      //! fix-me
                      // ignore: use_build_context_synchronously
                      context
                          .read<ListarCategoriaCubit>()
                          .listarCategorias(tipoCategoria);
                      controller.update(['categoriaList']);
                    });
                  },
                ),

                // listItem gerenciar categorias
                CustomListTileAction(
                  title: 'Gerenciar categorias',
                  icon: Icons.settings,
                  onTap: () {
                    Get.to(GerirCategoriasPage(tipoCategoria: tipoCategoria))
                        ?.then((value) {
                      controller.update(['categoriaList']);
                    });
                  },
                ),
                const GutterLarge(),
                const GutterLarge(),
                const GutterLarge(),
              ],
            );
          }),
    );
  }
}

class CustomListTileAction extends StatelessWidget {
  const CustomListTileAction({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });

  final String title;
  final GestureTapCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
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
