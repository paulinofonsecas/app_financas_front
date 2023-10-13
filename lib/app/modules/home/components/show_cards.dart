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
    controller = Get.put(HomePageController());
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

                  cartoes.insert(
                    0,
                    Cartao(
                      id: 0,
                      nome: 'Saldo disponivel',
                      numero: '0001',
                      saldo: cartoes.fold(
                        0,
                        (previousValue, element) =>
                            previousValue + element.saldo,
                      ),
                      bancoId: 0,
                    ),
                  );

                  return PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast,
                    ),
                    itemCount: cartoes.length,
                    itemBuilder: (context, index) {
                      var cartao = cartoes[index];
                      return LayoutBuilder(
                        builder: (c, constraines) => Container(
                          margin: const EdgeInsets.only(right: kDefaultPadding),
                          child: CardWidget(
                            index: index,
                            cartao: cartao,
                            width: size.width * 0.85,
                            height: index == 0
                                ? constraines.maxHeight
                                : constraines.maxHeight * 0.75,
                          ),
                        ),
                      );
                    },
                  );
                }),
          );
        });
  }
}
