import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/score/domain/entitys/movimento.dart';
import 'package:app_financas/score/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/score/domain/services/i_categoria_service.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ShowTransactionController extends GetxController {
  late final ICategoriaService categoriaService;
  late final SetupConfiguration setupConfiguration;
  late Movimento movimento;

  @override
  onInit() {
    categoriaService = getIt();
    setupConfiguration = Get.find<SetupConfiguration>();
    super.onInit();
  }

  void setMovimento(Movimento movimento) {
    this.movimento = movimento;
  }

  Future<String?> getCategoryName(int categoryId) async {
    late Either<Failure, List<Categoria>> result;

    if (movimento.tipoMovimentoId == 1) {
      result = await categoriaService.listValidCategoriasEntradas();
    } else {
      result = await categoriaService.listValidCategoriasSaidas();
    }

    if (result.isRight()) {
      var categorias = result.getOrElse(() => []);
      return categorias.where((element) => element.id == categoryId).first.name;
    } else {
      showErrorMessage('Erro', 'Erro ao buscar categoria');
      return null;
    }
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
