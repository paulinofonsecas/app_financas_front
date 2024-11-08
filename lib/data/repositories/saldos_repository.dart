import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/repositories/i_conta_repository.dart';
import 'package:app_financas/domain/repositories/i_saldos_repository.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:dartz/dartz.dart';

class SaldosRepository implements ISaldosRepository {
  final IMovimentoUseCases movimentoRepository;
  final IContaRepository contaRepository;

  SaldosRepository(this.movimentoRepository, this.contaRepository);

  @override
  Future<Either<Failure, double>> getEntradas() async {
    var list = getList(await movimentoRepository.listMovimentos());
    var result = list
        .where((element) => element.tipoMovimentoId == 1 && element.confirmado)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaRepository.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }

  @override
  Future<Either<Failure, double>> getSaidas() async {
    var list = getList(await movimentoRepository.listMovimentos());

    var result = list
        .where((element) => element.tipoMovimentoId == 2 && element.confirmado)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaRepository.getConta(mov.cartaoId))
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

  List<Movimento> getList(Either<Failure, List<Movimento>> result) {
    return result.getOrElse(() => []);
  }

  @override
  Future<Either<Failure, double>> getEntradasByConta(int contaId) async {
    var list = getList(await movimentoRepository.listMovimentos());
    var result = list
        .where((element) =>
            element.tipoMovimentoId == 1 &&
            element.confirmado &&
            element.cartaoId == contaId)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaRepository.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }

  @override
  Future<Either<Failure, double>> getSaidasByConta(int contaId) async {
    var list = getList(await movimentoRepository.listMovimentos());

    var result = list
        .where((element) =>
            element.tipoMovimentoId == 2 &&
            element.confirmado &&
            element.cartaoId == contaId)
        .toList();

    var soma = 0.0;
    for (var mov in result) {
      var conta = (await contaRepository.getConta(mov.cartaoId))
          .getOrElse(() => Conta.fake());

      if (mov.cartaoId == conta.id && conta.showInSoma == true) {
        soma += mov.valor;
      }
    }

    return Right(soma);
  }
}
