// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdicionarMovimentos extends StatelessWidget {
  const AdicionarMovimentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PageActionBar(
            title: 'Adicionar movimento',
            actionBack: () {
              Get.back();
            },
          ),
          SizedBox(height: kDefaultPadding),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kVerdeAccentColor,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Entrada',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                color: kVerdeAccentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: kVermelhaColor,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Saida',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
