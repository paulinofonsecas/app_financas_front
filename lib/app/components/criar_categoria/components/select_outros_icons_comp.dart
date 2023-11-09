import 'package:app_financas/app/components/editar_categoria/controllers/editar_categoria_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/criar_categoria_controller.dart';

class SelectOutrosIconsComponent extends StatelessWidget {
  const SelectOutrosIconsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CriarCategoriaController>();

    return InkWell(
      onTap: () async {
        IconData? icon = await FlutterIconPicker.showIconPicker(
          context,
          iconPackModes: [IconPack.fontAwesomeIcons],
          iconSize: 32,
          title: const Text('Selecione um Icone'),
          searchHintText: 'Pesquise um Icone (em inglês)',
          closeChild: const Text('Fechar'),
          noResultsText: 'Nenhum resultado encontrado',
        );

        if (icon != null) {
          controller.changeIconFromPicker(icon);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 3.3),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(90),
        ),
        child: Center(
          child: Text(
            'Outros',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
