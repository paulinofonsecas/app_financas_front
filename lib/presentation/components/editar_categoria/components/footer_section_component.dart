import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/editar_categoria_controller.dart';

class FooterSectionComponent extends StatelessWidget {
  const FooterSectionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditarCategoriaController>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancelar',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Gutter(),
        FilledButton(
          onPressed: () {
            controller.editarCategoria().then((value) {
              Navigator.of(context).pop();
            });
          },
          child: Text(
            'salvar',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
