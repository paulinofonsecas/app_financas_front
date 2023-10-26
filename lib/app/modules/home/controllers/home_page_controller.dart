import 'package:app_financas/core/data/provider/interfaces/i_categoria_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  late final IMovimentoService movimentoService;
  late final ISaldosService saldosService;
  late ICategoriaProvider categoriaProvider;
  late IContaProvider contaProvider;
  var showMoneyOnCards = false.obs;
  var cartoes = <Conta>[];

  @override
  void onInit() {
    categoriaProvider = Get.find();
    contaProvider = Get.find();
    movimentoService = Get.find();
    saldosService = Get.find();
    super.onInit();
  }

  void changeViewManyCards() {
    showMoneyOnCards.value = !showMoneyOnCards.value;
  }

  Future<double> getSaldoDisponivel() async {
    var result = await saldosService.getSaldoDisponivel();
    if (result is Right) {
      return result.getOrElse(() => 0);
    } else {
      return 0;
    }
  }

  Future<double> getEntradasDoMes() async {
    var result = await saldosService.getEntradas();
    if (result is Right) {
      return result.getOrElse(() => 0);
    } else {
      return 0;
    }
  }

  Future<double> getSaidasDoMes() async {
    var result = await saldosService.getSaidas();
    if (result is Right) {
      return result.getOrElse(() => 0);
    } else {
      return 0;
    }
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

  Future<List<Conta>> getCartoes() async {
    var contaService = Get.find<IContaProvider>();
    var result = await contaService.listContas();

    if (result is Right) {
      cartoes = result.getOrElse(() => []);
      return cartoes;
    } else {
      return [];
    }
  }

  Future<void> refreshSaldosDeCartoes() async {
    await getCartoes();
    update();
  }
}
