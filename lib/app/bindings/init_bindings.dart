import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_conta_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/http/http_saldos_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_categoria_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_saldos_provider.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/data/services/conta_service.dart';
import 'package:app_financas/core/data/services/movimento_service.dart';
import 'package:app_financas/core/data/services/saldos_service.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
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

    // Movimentos
    Get.lazyPut<IMovimentoProvider>(
      () => DbMovimentoProvider(),
      fenix: true,
    );
    Get.lazyPut<IMovimentoService>(
      () => MovimentoService(provider: Get.find()),
      fenix: true,
    );

    Get.lazyPut<SetupConfiguration>(
      () => SetupConfiguration.local(),
    );

    Get.put<ISaldosService>(SaldosService(Get.find()));

    // Categoria
    Get.lazyPut<ICategoriaProvider>(() => DbCategoriaProvider());
    Get.lazyPut<ICategoriaService>(() => CategoriaService(Get.find()));

    // Conta
    Get.lazyPut<IContaProvider>(() => DbContaProvider());
    Get.lazyPut<IContaService>(() => ContaService(Get.find()));
  }
}
