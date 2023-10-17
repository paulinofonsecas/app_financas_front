import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:get/get.dart';

class ShowTransactionController extends GetxController {
  late final SetupConfiguration setupConfiguration;

  @override
  onInit() {
    setupConfiguration = Get.find<SetupConfiguration>();
    super.onInit();
  }

  String getCategoryName(int categoryId) {
    return setupConfiguration.categorias
        .where((element) => element.id == categoryId)
        .first
        .name;
  }

  String getAccountName(int cartaoId) {
    return setupConfiguration.cartoes
        .where((element) => element.id == cartaoId)
        .first
        .nome;
  }
}
