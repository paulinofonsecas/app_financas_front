import 'package:app_financas/presentation/components/page_action_bar.dart';
import 'package:app_financas/presentation/modules/home/components/entradas_saidas.dart';
import 'package:app_financas/presentation/modules/movimentos/controllers/movimentos_screen_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: GetBuilder(
          init: controller,
          id: 'geral',
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PageActionBar(
                  title: 'Movimentos',
                  rightWidget: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_list,
                    ),
                  ),
                  actionBack: () {
                    Get.back();
                  },
                ),
                const EntradasESaidas(),
                const SizedBox(height: kDefaultPadding / 2),
                _buildHeaderPage(),
                const SizedBox(height: kDefaultPadding / 2),
                Body(controller: controller),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderPage() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     Text(
          //       'Filtros: ',
          //       style: GoogleFonts.inter(
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
