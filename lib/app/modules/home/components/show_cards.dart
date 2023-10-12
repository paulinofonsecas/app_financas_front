import 'package:app_financas/app/modules/home/components/total_balance.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCards extends StatefulWidget {
  const ShowCards({super.key});

  @override
  State<ShowCards> createState() => _ShowCardsState();
}

class _ShowCardsState extends State<ShowCards> {
  var pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());
    var size = MediaQuery.of(context).size;
    var cartoes = controller.getCartoes();

    return SizedBox(
      width: size.width,
      height: size.height * 0.23,
      child: PageView.builder(
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
                width: size.width * 0.85,
                height: index == 0
                    ? constraines.maxHeight
                    : constraines.maxHeight * 0.75,
                cartao: cartao,
              ),
            ),
          );
        },
      ),
    );
  }
}
