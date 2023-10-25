import 'package:app_financas/app/modules/home/components/total_balance.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
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
        id: 'cards',
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * 0.23,
            child: FutureBuilder<List<Cartao>>(
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
                    var saldoTotal = cartoes.fold(
                        0.0,
                        (previousValue, element) =>
                            previousValue + element.saldo);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: CardWidget(
                        index: 0,
                        saldo: saldoTotal,
                        width: size.width * 0.85,
                        height: constraines.maxHeight * 0.75,
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
