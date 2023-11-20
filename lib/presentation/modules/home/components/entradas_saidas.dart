// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EntradasESaidas extends StatelessWidget {
  const EntradasESaidas({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomePageController>();

    return GetBuilder(
      init: controller,
      id: 'geral',
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: kBlackColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<double>(
                  future: controller.getEntradasDoMes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return EntradaOuSaidaWidget(
                        asset: 'assets/svgs/home_page/Arrow_down.svg',
                        title: 'Entradas',
                        valor: snapshot.data ?? 0,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                FutureBuilder<double>(
                  future: controller.getSaidasDoMes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return EntradaOuSaidaWidget(
                        asset: 'assets/svgs/home_page/Arrow_up.svg',
                        title: 'Saidas',
                        valor: snapshot.data ?? 0,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EntradaOuSaidaWidget extends StatelessWidget {
  const EntradaOuSaidaWidget({
    super.key,
    required this.asset,
    required this.title,
    required this.valor,
  });

  final String asset;
  final String title;
  final double valor;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomePageController>();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(asset, width: 16),
              SizedBox(width: kDefaultPadding / 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GutterTiny(),
          Obx(
            () => Text(
              controller.showMoneyOnCards.value
                  ? numberFormat.format(valor)
                  : '********',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
