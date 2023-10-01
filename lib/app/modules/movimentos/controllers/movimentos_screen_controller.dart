import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class MovimentoScreenController extends GetxController {
  late final IMovimentoService service;

  @override
  void onInit() {
    service = Get.find();
    super.onInit();
  }

  Future<Either<Failure,List<Movimento>>> listMovimentos() {
    return service.listMovimentos();
  }
}
