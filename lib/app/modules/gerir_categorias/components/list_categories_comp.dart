// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/modules/gerir_categorias/controllers/gerir_categoria_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCategoriesComp extends StatelessWidget {
  const ListCategoriesComp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GerirCategoriaController>();

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: kDefaultPadding),
        decoration: BoxDecoration(
          color: Get.theme.dialogBackgroundColor,
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

                    return CategoriaItem(categoria: categoria);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoriaItem extends StatelessWidget {
  const CategoriaItem({
    Key? key,
    required this.categoria,
    this.onTap,
  }) : super(key: key);

  final Categoria categoria;
  final GestureTapCallback? onTap;

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
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
