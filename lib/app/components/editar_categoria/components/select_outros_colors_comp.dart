import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/editar_categoria_controller.dart';

class SelectOutrosColorsComponent extends StatelessWidget {
  const SelectOutrosColorsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditarCategoriaController>();

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Selecionar cor'),
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: controller.categoria.color ?? Colors.blue,
                onColorChanged: (c) {
                  controller.changeColorFromPicker(c);
                  Get.back();
                },
                enableLabel: false, // only on portrait mode
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Concluído'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 3.3),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(90),
        ),
        child: Center(
          child: Text(
            'Outra',
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
