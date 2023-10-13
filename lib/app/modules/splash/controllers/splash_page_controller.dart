// ignore_for_file: deprecated_member_use

import 'package:app_financas/app/modules/home/home_page.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_setup_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  final ISetupService setupService;
  var isLoading = false.obs;

  SplashPageController(this.setupService);

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    isLoading.value = true;
    var result = await setupService.setup();

    if (result is Right) {
      var setupConfig = result.getOrElse(() => SetupConfiguration.zero());

      if (setupConfig == SetupConfiguration.zero()) {
        isLoading.value = false;
        showErrorSnackBar();
      } else {
        isLoading.value = false;
        Get.put(setupConfig, permanent: true);
        Get.off(const HomePage());
      }
    } else {
      isLoading.value = false;
      showErrorSnackBar();
    }
  }

  void showErrorSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Erro de conexão',
        message: 'Clique para tentar novamente',
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        isDismissible: true,
        mainButton: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () {
            Get.back();
            init();
          },
          child: const Text('Tentar novamente'),
        ),
      ),
    );
  }
}
