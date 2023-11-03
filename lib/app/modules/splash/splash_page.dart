// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:app_financas/app/modules/splash/controllers/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SplashPageController());
    c.init();


    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                'assets/imgs/logo.jpg',
                width: 200,
                height: 200,
              ),
            ),
          ),
          const Spacer(),
          Obx(
            () => c.isLoading.value
                ? const CircularProgressIndicator()
                : c.loadingError.value
                    ? TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          Get.back();
                          c.init();
                        },
                        icon: Icon(Icons.refresh, color: Colors.green[700]),
                        label: const Text('Tentar novamente'),
                      )
                    : const Text(''),
          ),
          GutterLarge(),
          GutterLarge(),
          GutterLarge(),
        ],
      ),
    );
  }
}
