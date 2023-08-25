// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:app_financas/app/screens/home/abbas/movimentos.dart';
import 'package:app_financas/app/screens/movimentos/components/combo_box_filter.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MovimentosScreen extends StatelessWidget {
  const MovimentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PageActionBar(
            title: 'Movimentos',
            actionBack: () {
              Get.back();
            },
            // rightWidget: IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            // ),
          ),
          _buildHeaderPage(),
          SizedBox(height: kDefaultPadding),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView.builder(
                itemBuilder: (_, index) => MovimentoItem(
                  asset: 'assets/svgs/categories/desktop.svg',
                  title: 'Adobe Photoshop',
                  conta: 'Cartão do Bai',
                  valor: '-Kz 1.000,00',
                  avatarBgColor: kAmarelhoColor,
                ),
                itemCount: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildHeaderPage() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Filtrar por',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ComboBoxFilter(),
          ],
        ),
      ],
    ),
  );
}
