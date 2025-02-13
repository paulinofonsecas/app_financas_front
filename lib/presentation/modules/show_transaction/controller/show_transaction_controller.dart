import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/entities/sertup_configuration.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';
import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ShowTransactionController extends GetxController {
  late final ICategoriaUseCases categoriaService;
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

  Future<String> getAccountName(int contaId) async {
    final contaUseCases = getIt<IContaUseCases>();
    final result = await contaUseCases.getConta(contaId);

    if (result.isLeft()) {
      return 'S/N';
    }

    final conta = result.getOrElse(Conta.fake);
    return conta.nome;
  }

  void updateMovimento(value) {
    movimento = value;
    update();
  }
}
