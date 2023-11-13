import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/estatistica_por_categoria.dart';
import 'controller/estatisticas_page_controller.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  late final EstatisticasPageController controller;

  @override
  void initState() {
    controller = Get.put(EstatisticasPageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        id: 'geral',
        builder: (context) {
          return Column(
            children: [
              headerSection(),
              const Gutter(),
              const EstatisticaPorCategoria(),
            ],
          );
        },
      ),
    );
  }

  Widget headerSection() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Text(
            'Estatisticas',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
