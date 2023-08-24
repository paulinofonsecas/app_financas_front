// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'button_go_to_carteira.dart';
import 'info_balance.dart';

class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.21,
        decoration: BoxDecoration(
          color: kBlackColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/svgs/home_page/decoracao_1.svg',
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Transform.rotate(
                // rotate a 360 graus
                angle: pi,
                child: SvgPicture.asset(
                  'assets/svgs/home_page/decoracao_2.svg',
                  width: 90,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding * 1.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoBalance(),
                  Spacer(),
                  ButtonGoToCarteira(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
