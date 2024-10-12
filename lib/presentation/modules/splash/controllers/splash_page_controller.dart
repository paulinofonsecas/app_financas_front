// ignore_for_file: deprecated_member_use

import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/on_boarding/view/on_boarding_page.dart';
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
    categoriaService = getIt();
    contaService = getIt();

    super.onInit();
  }

  Future<void> init() async {
    isLoading.value = true;
    var categoriaEntradasResult =
        await categoriaService.listValidCategoriasEntradas();
    var categoriasSaidasResult =
        await categoriaService.listValidCategoriasSaidas();
    var contaResult = await contaService.listContas();

    var categoriaEntradasList = categoriaEntradasResult.getOrElse(() => []);
    var categoriasSaidasList = categoriasSaidasResult.getOrElse(() => []);
    var contaList = contaResult.getOrElse(() => []);

    var setupConfig = SetupConfiguration(
      categoriasEntradas: categoriaEntradasList,
      categoriasSaidas: categoriasSaidasList,
      contas: contaList,
      isLocal: true,
    );

    _goToHomePage(setupConfig);
  }

  Future? _goToHomePage(SetupConfiguration setupConfig) {
    Get.replace(setupConfig);
    return Get.off(() => const OnBoardingPage(), transition: Transition.fadeIn);
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
            foregroundColor: Colors.white,
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
