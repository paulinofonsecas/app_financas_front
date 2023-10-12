// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_page_controller.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.cartao,
    required this.width,
    required this.height,
  });

  final Cartao cartao;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kBlackColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Background(),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding * 1.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    cartao.nome,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => Text(
                      controller.showMoneyOnCards.value
                          ? numberFormat.format(cartao.saldo)
                          : '**********',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GutterTiny(),
                  // mostrar icon de olhos para ver o valor
                  IconButton(
                    onPressed: controller.changeViewManyCards,
                    icon: Obx(
                      () => Icon(
                        controller.showMoneyOnCards.value
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}
