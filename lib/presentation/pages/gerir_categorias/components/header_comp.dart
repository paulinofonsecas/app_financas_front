import 'package:app_financas/presentation/widgets/categorias_arquivadas/archived_bottom_category_component.dart';
import 'package:app_financas/presentation/helders/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/gerir_categoria_controller.dart';

class HeaderComp extends StatelessWidget {
  const HeaderComp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GerirCategoriaController>();
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Fechar',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      BottomCategoryArchivedComponent.openModalBottomSheet(
                        context,
                        controller.tipoCategoria,
                      ).then((value) {
                        controller.update(['geral', 'categoriaList']);
                      });
                    },
                    icon: const Icon(
                      CupertinoIcons.archivebox,
                      color: Colors.white,
                    ),
                  ),
                  const GutterTiny(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding / 2),
              child: Text(
                'Categorias',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
