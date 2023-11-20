import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size(Get.size.width / 2.5, 50),
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 3,
              vertical: kDefaultPadding,
            ),
            side: const BorderSide(
              color: Colors.purple,
              width: 2,
            ),
            foregroundColor: Colors.purple,
          ),
          child: Text(
            'Cancelar',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            controller.editarCategoria().then((value) {
              Navigator.of(context).pop();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            minimumSize: Size(Get.size.width / 2.5, 50),
          ),
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
