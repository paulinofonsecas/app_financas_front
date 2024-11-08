import 'package:app_financas/score/data/provider/http/http_setup_provider.dart';
import 'package:app_financas/score/data/provider/interfaces/i_setup_provider.dart';
import 'package:app_financas/score/data/services/setup_service.dart';
import 'package:app_financas/score/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/score/domain/services/i_setup_service.dart';
import 'package:app_financas/presentation/helders/http_helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InitBingings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(
      () => makeDefaultDio(),
      fenix: true,
    );

    // Setup
    Get.lazyPut<SetupConfiguration>(
      () => SetupConfiguration.local(),
    );

    Get.lazyPut<ISetupProvider>(
      () => HttpSetupProvider(Get.find()),
      fenix: true,
    );
    Get.lazyPut<ISetupService>(
      () => SetupService(Get.find()),
      fenix: true,
    );
  }
}
