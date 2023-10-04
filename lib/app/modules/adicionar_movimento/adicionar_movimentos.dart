// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:app_financas/app/utils.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdicionarMovimentos extends StatelessWidget {
  const AdicionarMovimentos({super.key});

  @override
  Widget build(BuildContext context) {
    var tipoMovimento = Get.arguments as TipoMovimento;

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
                  Text(tipoMovimento.name),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
