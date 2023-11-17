import 'package:app_financas/app/modules/home/abbas/movimentos.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/app/modules/movimentos/movimentos_screen.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenMovimentosWidget extends StatelessWidget {
  const HomeScreenMovimentosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomePageController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding * 2),
          FutureBuilder<List<Movimento>>(
            future: controller.listMovimentosDoDia(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              if (snapshot.hasData) {
                return MovimentosAtHomePage(
                  movimentos: snapshot.data ?? [],
                  verMaisAction: () {
                    Get.to(const MovimentosScreen());
                  },
                );
              } else {
                return const Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
