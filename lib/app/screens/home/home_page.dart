// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/action_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ActionBar(),
          Padding(
            padding: EdgeInsets.all(27.0),
            child: TotalBalanceCard(),
          ),
        ],
      ),
    );
  }
}

class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kBlackColor,
      ),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saldo disponivel',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          Text(
            'Kz 650.000.000,00',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 42,
            ),
          ),
        ],
      ),
    );
  }
}
