import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  late final IMovimentoService movimentoService;

  @override
  void onInit() {
    movimentoService = Get.find();
    super.onInit();
  }

  Future<List<Movimento>> listMovimentosDoDia() async {
    var result = await movimentoService.listMovimentos();

    if (result is Right) {
      var list = result.getOrElse(() => []);
      if (list.length > 10) {
        return list.sublist(0, 6);
      } else {
        return list;
      }
    } else {
      return [];
    }
  }
}
