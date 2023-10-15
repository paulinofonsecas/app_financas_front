import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:app_financas/app/modules/movimentos/controllers/movimentos_screen_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/body.dart';

class MovimentosScreen extends StatefulWidget {
  const MovimentosScreen({super.key});

  @override
  State<MovimentosScreen> createState() => _MovimentosScreenState();
}

class _MovimentosScreenState extends State<MovimentosScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MovimentoScreenController());

    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PageActionBar(
                title: 'Movimentos',
                actionBack: () {
                  Get.back();
                },
              ),
              _buildHeaderPage(),
              const SizedBox(height: kDefaultPadding),
              Body(controller: controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeaderPage() {
    var controller = Get.find<MovimentoScreenController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Filtrar por',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      Get.theme.colorScheme.surfaceTint.withOpacity(.1),
                ),
                onPressed: () {
                  controller.selecionarDateTime(context);
                },
                child: const Text('Selecionar data'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
