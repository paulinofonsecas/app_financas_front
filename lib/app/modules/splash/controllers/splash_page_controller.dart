// ignore_for_file: deprecated_member_use

import 'package:app_financas/app/modules/home/home_page.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  late ICategoriaService categoriaService;
  late IContaService contaService;
  var isLoading = false.obs;
  var loadingError = true.obs;

  SplashPageController();

  @override
  void onInit() {
    categoriaService = Get.find();
    contaService = Get.find();

    init();
    super.onInit();
  }

  void init() async {
    // var syncService = SyncDataService();
    // await syncService.syncData();

    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = true;
    var categoriaResult = await categoriaService.listCategoriasEntradas();
    var contaResult = await contaService.listContas();

    var categoriaEntradasList = categoriaResult.getOrElse(() => []);
    var contaList = contaResult.getOrElse(() => []);

    var setupConfig = SetupConfiguration(
      categorias: categoriaEntradasList,
      contas: contaList,
      isLocal: true,
    );

    _goToHomePage(setupConfig);
  }

  void _goToHomePage(SetupConfiguration setupConfig) {
    Get.replace(setupConfig);
    Get.off(const HomePage());
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
