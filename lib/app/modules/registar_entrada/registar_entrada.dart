// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/select_date_component.dart';
import 'controllers/registar_entrada_controller.dart';

class RegistarEntrada extends StatelessWidget {
  const RegistarEntrada({super.key});

  @override
  Widget build(BuildContext context) {
    // var tipoMovimento = Get.arguments as TipoMovimento;
    var controller = Get.put(RegistarEntradaController());

    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageActionBar(
            title: 'Registar entrada',
            actionBack: () {
              Get.back();
            },
          ),
          SizedBox(height: kDefaultPadding),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.descricaoTextController,
                    decoration: InputDecoration(
                      labelText: 'Descrição da entrada',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  // Date picker
                  Gutter(),
                  SelectDateComponent(controller: controller),
                  Gutter(),
                  TextFormField(
                    controller: controller.valorTextController,
                    onChanged: controller.onValorChange,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      prefixText: 'Kz ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  // implementar um select box para categorias
                  Gutter(),
                  GetBuilder(
                    id: 'conta',
                    init: controller,
                    builder: (context) {
                      return DropdownButton<int>(
                        value: controller.cartaoId,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(8),
                        padding: EdgeInsets.all(kDefaultPadding / 4),
                        hint: Text('Conta de destino'),
                        onChanged: (int? value) {
                          if (value == null) {
                            return;
                          }
                          controller.cartaoId = value;
                          controller.update(['conta']);
                        },
                        items: controller
                            .getCards()
                            .map((c) => DropdownMenuItem(
                                  value: c.id,
                                  child: Text(c.nome),
                                ))
                            .toList(),
                      );
                    },
                  ),
                  Gutter(),
                  TextField(
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Observações',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  GutterLarge(),
                  buildButtonsWidget(),
                  Gutter(),
                  /*
                    * Descricao
                    * Data
                    * Valor
                    * Categoria
                    * conta
                  */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildButtonsWidget() {
  var controller = Get.find<RegistarEntradaController>();
  return Align(
    alignment: Alignment.topCenter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton(
          onPressed: () async {
            await controller.finalizarMovimento();
            if (controller.salvo) {
              Get.back(closeOverlays: true);
            }
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 3,
              vertical: kDefaultPadding,
            ),
          ),
          child: Text(
            'Finalizar',
            style: GoogleFonts.inter().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GutterSmall(),
        OutlinedButton(
          onPressed: () {
            Get.back();
          },
          style: OutlinedButton.styleFrom(
            primary: Colors.red[400],
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 3,
              vertical: kDefaultPadding,
            ),
          ),
          child: Text(
            'Cancelar',
            style: GoogleFonts.inter().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
