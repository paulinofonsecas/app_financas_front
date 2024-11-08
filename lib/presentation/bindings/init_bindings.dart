import 'package:app_financas/data/repositories/setup_service.dart';
import 'package:app_financas/domain/entities/sertup_configuration.dart';
import 'package:app_financas/domain/repositories/i_setup_repository.dart';
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

    Get.lazyPut<ISetupRepository>(
      () => SetupRepository(Get.find()),
      fenix: true,
    );
  }
}
