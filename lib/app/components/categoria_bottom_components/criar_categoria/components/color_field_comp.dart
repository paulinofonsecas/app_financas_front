// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/criar_categoria_controller.dart';
import 'color_picker_list.dart';

class ColorFieldComp extends StatelessWidget {
  const ColorFieldComp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CriarCategoriaController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.color_lens,
          color: Colors.grey,
        ),
        Gutter(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cor',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gutter(),
              GetBuilder(
                init: controller,
                id: 'color',
                builder: (context) {
                  return ColorPickerList();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
