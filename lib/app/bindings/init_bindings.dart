import 'package:app_financas/core/data/provider/http_movimento_provider.dart';
import 'package:app_financas/core/data/provider/http_saldos_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_saldos_provider.dart';
import 'package:app_financas/core/data/services/movimento_service.dart';
import 'package:app_financas/core/data/services/saldos_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/helders/http_helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class InitBingings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(
      () => makeDefaultDio(),
      fenix: true,
    );
    Get.lazyPut<IMovimentoProvider>(
      () => HttpMovimentoProvider(Get.find()),
      fenix: true,
    );
    Get.lazyPut<IMovimentoService>(
      () => MovimentoService(provider: Get.find()),
      fenix: true,
    );
    Get.lazyPut<ISaldosProvider>(
      () => HttpSaldosProvider(Get.find()),
    );
    Get.put<ISaldosService>(SaldosService(Get.find()));
  }
}
