// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:app_financas/presentation/modules/splash/controllers/splash_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashPageController c;

  @override
  void initState() {
    c = Get.put(SplashPageController());
    c.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Obx(
                () => c.isLoading.value
                    ? const Text('Carregando')
                    : c.loadingError.value
                        ? TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.green,
                            ),
                            onPressed: () {
                              // Get.back();
                              c.init();
                            },
                            icon: Icon(Icons.refresh, color: Colors.green[700]),
                            label: const Text('Tentar novamente'),
                          )
                        : const Text(''),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
