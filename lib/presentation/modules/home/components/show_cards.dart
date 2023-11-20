import 'package:app_financas/presentation/modules/home/components/card_widget.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCards extends StatefulWidget {
  const ShowCards({super.key});

  @override
  State<ShowCards> createState() => _ShowCardsState();
}

class _ShowCardsState extends State<ShowCards> {
  late final HomePageController controller;
  var pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  @override
  void initState() {
    controller = Get.find<HomePageController>();

    controller.getCartoes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder(
        init: controller,
        id: 'geral',
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * 0.23,
            child: FutureBuilder<List<Conta>>(
              future: controller.getCartoes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var cartoes = snapshot.data ?? [];

                if (cartoes.isEmpty) {
                  return const Center(
                    child: Text('Nenhum cartão cadastrado'),
                  );
                }

                return LayoutBuilder(
                  builder: (c, constraines) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: CardWidget(
                        width: size.width * 0.85,
                        height: 176,
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
