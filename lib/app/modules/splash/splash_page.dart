// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/modules/splash/controllers/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SplashPageController(Get.find()));
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/imgs/logo.png',
              width: 150,
              height: 150,
            ),
          ),
          Gutter(),
          Text(
            'Me Poupe',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.amber[700],
            ),
          ),
          const Spacer(),
          Obx(
            () => c.isLoading.value
                ? const CircularProgressIndicator()
                : TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      Get.back();
                      c.init();
                    },
                    icon: Icon(Icons.refresh, color: Colors.green[700]),
                    label: const Text('Tentar novamente'),
                  ),
          ),
          GutterLarge(),
          GutterLarge(),
          GutterLarge(),
        ],
      ),
    );
  }
}
