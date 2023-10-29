// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/helders/format_helpers.dart';

import '../controllers/home_page_controller.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomePageController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: width,
        height: height,
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
                    "Saldo disponivel em contas",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  FutureBuilder<double>(
                    future: controller.getSaldoDisponivel(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Obx(
                          () => Text(
                            controller.showMoneyOnCards.value
                                ? numberFormat.format(snapshot.data ?? 0.0)
                                : '**********',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
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
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.onInverseSurface,
    );
  }
}
