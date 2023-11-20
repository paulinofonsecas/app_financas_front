// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/modules/gerir_categorias/controllers/gerir_categoria_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TipoCategoriaSwitchComp extends StatelessWidget {
  const TipoCategoriaSwitchComp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GerirCategoriaController>();
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 2,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.3),
        borderRadius: BorderRadius.circular(90),
      ),
      child: GetBuilder(
        init: controller,
        id: 'switch_categoria_actions',
        builder: (c) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SelectableCategoriaItem(
                title: 'Dispesas',
                onTap: () {
                  controller.changeTipoCategoria(TipoCategoria.saida);
                },
                isSelected: controller.tipoCategoria == TipoCategoria.saida,
              ),
              SelectableCategoriaItem(
                title: 'Receitas',
                onTap: () {
                  controller.changeTipoCategoria(TipoCategoria.entrada);
                },
                isSelected: controller.tipoCategoria == TipoCategoria.entrada,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SelectableCategoriaItem extends StatelessWidget {
  const SelectableCategoriaItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GerirCategoriaController>();

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: isSelected ? Colors.white : Colors.transparent,
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: controller.tipoCategoria == TipoCategoria.entrada
                    ? kVerdeForteColor
                    : kVermelhaForteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
