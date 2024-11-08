import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';
import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:app_financas/domain/usecases/i_saldos_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  late final IMovimentoUseCases movimentoService;
  late final ISaldosUseCases saldosService;
  late ICategoriaUseCases categoriaProvider;
  late IContaUseCases contaProvider;
  var showMoneyOnCards = false.obs;
  var cartoes = <Conta>[];

  late BuildContext context;

  @override
  void onInit() {
    categoriaProvider = getIt();
    contaProvider = getIt();
    movimentoService = getIt();
    saldosService = getIt();
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
      var list = result.getOrElse(() => [])
        ..sort((a, b) => a.data.compareTo(b.data));
      list = list.reversed.toList();
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
    var contaService = getIt<IContaUseCases>();
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

  void setContext(BuildContext context) {
    this.context = context;
  }
}
