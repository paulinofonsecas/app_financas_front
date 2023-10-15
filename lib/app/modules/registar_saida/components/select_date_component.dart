import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/registar_transacao_controller.dart';

class SelectDateComponent extends StatelessWidget {
  const SelectDateComponent({
    super.key,
    required this.controller,
  });

  final RegistarTransacaoController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder(
          init: controller,
          builder: (context) {
            return Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: controller.getSelectedDate(),
                  hintStyle: GoogleFonts.inter().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                ),
              ),
            );
          },
        ),
        const Gutter(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Get.theme.colorScheme.surfaceTint.withOpacity(.1),
          ),
          onPressed: () {
            controller.selecionarDateTime(context);
          },
          child: const Text('Selecionar data'),
        ),
      ],
    );
  }
}
