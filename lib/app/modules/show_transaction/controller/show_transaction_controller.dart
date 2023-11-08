import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:get/get.dart';

class ShowTransactionController extends GetxController {
  late final SetupConfiguration setupConfiguration;
  late Movimento movimento;

  @override
  onInit() {
    setupConfiguration = Get.find<SetupConfiguration>();
    super.onInit();
  }

  void setMovimento(Movimento movimento) {
    this.movimento = movimento;
  }

  String getCategoryName(int categoryId) {
    return setupConfiguration.categoriasEntradas
        .where((element) => element.id == categoryId)
        .first
        .name;
  }

  String getAccountName(int cartaoId) {
    return setupConfiguration.contas
        .where((element) => element.id == cartaoId)
        .first
        .nome;
  }

  void updateMovimento(value) {
    movimento = value;
    update();
  }
}
