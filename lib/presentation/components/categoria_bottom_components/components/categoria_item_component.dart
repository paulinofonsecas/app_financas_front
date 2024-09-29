// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/categoria_bottom_components/components/bottom_category_comp_controller.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriaItem extends StatelessWidget {
  const CategoriaItem({
    super.key,
    required this.categoria,
    this.onTap,
    required this.isSelected,
    this.selectedCategoriaId,
  });

  final Categoria categoria;
  final GestureTapCallback? onTap;
  final bool isSelected;
  final int? selectedCategoriaId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Column(
        children: [
          ListTile(
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
              ),
            ),
            leading: CircleAvatar(
              backgroundColor:
                  categoria.color ?? Theme.of(context).colorScheme.primary,
              child: Icon(
                categoria.icon ?? Icons.icecream,
                color: Colors.white,
                size: 16,
              ),
            ),
            trailing: Checkbox(
              value: selectedCategoriaId == categoria.id,
              onChanged: (c) {
                onTap?.call();
              },
              shape: const CircleBorder(),
            ),
          ),
          if (categoria.subCategorias.isNotEmpty) ...[
            const Gutter(),
            ...(categoria.subCategorias
                  ..sort((a, b) => a.name.compareTo(b.name)))
                .map((e) => SubCategoriaItem(
                      categoriaMae: categoria,
                      categoria: e,
                      isSelected: categoria.subCategoria?.id == e.id,
                      onTap: onTap,
                    ))
          ],
        ],
      ),
    );
  }
}

class SubCategoriaItem extends StatelessWidget {
  const SubCategoriaItem({
    super.key,
    this.onTap,
    required this.categoriaMae,
    required this.categoria,
    required this.isSelected,
  });

  final Categoria categoriaMae;
  final Categoria categoria;
  final GestureTapCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BottomCategoryCompController>();

    return InkWell(
      onTap: () {
        controller.searchTextController.clear();
        final selectedCategoria = categoriaMae.copyWith(
          subCategoria: categoria,
        );
        context
            .read<SelectCategoriaCubit>()
            .selectedCategoria(selectedCategoria);
        Navigator.of(context).pop(categoria);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        child: Row(
          children: [
            const GutterLarge(),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: categoria.color,
              ),
            ),
            const Gutter(),
            Text(
              categoria.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Gutter(),
          ],
        ),
      ),
    );
  }
}
