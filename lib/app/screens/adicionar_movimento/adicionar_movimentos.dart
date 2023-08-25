// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdicionarMovimentos extends StatelessWidget {
  const AdicionarMovimentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        children: [
          PageActionBar(
            title: 'Adicionar movimento',
            actionBack: () {
              Get.back();
            },
            // rightWidget: IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            // ),
          ),
        ],
      ),
    );
  }
}
