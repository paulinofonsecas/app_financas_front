import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/data/datasources/interfaces/i_contas_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_movimento_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_saldos_provider.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';

class DBSaldosProvider implements ISaldosProvider {
  final IMovimentoProvider movimentoService;
  late final IContaProvider contaService;

  DBSaldosProvider(this.movimentoService, this.contaService);

  @override
  Future<Either<Failure, double>> getEntradas() async {
    var list = _getList(await movimentoService.listMovimentos());
    var result = list
        .where((element) => element.tipoMovimentoId == 1 && element.confirmado)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaService.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }

  @override
  Future<Either<Failure, double>> getSaidas() async {
    var list = _getList(await movimentoService.listMovimentos());

    var result = list
        .where((element) => element.tipoMovimentoId == 2 && element.confirmado)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaService.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }

  @override
  Future<Either<Failure, double>> getSaldoDisponivel() async {
    var entradas = (await getEntradas()).getOrElse(() => 0.0);
    var saidas = (await getSaidas()).getOrElse(() => 0.0);

    return Right(entradas - saidas);
  }

  List<Movimento> _getList(Either<Failure, List<Movimento>> result) {
    return result.getOrElse(() => []);
  }

  @override
  Future<Either<Failure, double>> getEntradasByConta(int contaId) async {
    var list = _getList(await movimentoService.listMovimentos());
    var result = list
        .where((element) =>
            element.tipoMovimentoId == 1 &&
            element.confirmado &&
            element.cartaoId == contaId)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaService.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }

  @override
  Future<Either<Failure, double>> getSaidasByConta(int contaId) async {
    var list = _getList(await movimentoService.listMovimentos());

    var result = list
        .where((element) =>
            element.tipoMovimentoId == 2 &&
            element.confirmado &&
            element.cartaoId == contaId)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaService.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }
}
