// ignore_for_file: deprecated_member_use

import 'package:app_financas/app/modules/home/home_page.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_setup_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  final ISetupService setupService;
  var isLoading = false.obs;
  var loadingError = true.obs;

  SplashPageController(this.setupService);

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void _goToHomePage(SetupConfiguration setupConfig) {
    if (setupConfig.isLocal) {
      Get.lazyReplace<IMovimentoProvider>(() => DbMovimentoProvider());
    }

    Get.put(setupConfig, permanent: true);
    Get.off(const HomePage());
  }

  void init() async {
    isLoading.value = true;
    var result = await setupService.setup();

    var setupConfig = result.getOrElse(() => SetupConfiguration.local());
    _goToHomePage(setupConfig);
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
