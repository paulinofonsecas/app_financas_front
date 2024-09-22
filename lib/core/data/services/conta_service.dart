import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/tipo_conta.dart';
import 'package:app_financas/core/domain/services/i_banco_service.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ContaService implements IContaService {
  final IContaProvider _provider;
  final IBancoService _bancoService;
  final IMovimentoService _movimentoService;

  ContaService(this._provider, this._movimentoService, this._bancoService);

  @override
  Future<Either<Failure, List<Conta>>> listContas([int? mes]) async {
    final result = await _provider.listContas(mes);

    return result.fold(
      (l) => Left(Failure(l.message)),
      (contas) async {
        if (contas.isEmpty) {
          // return const Right([]);
          await _generateDefaultAccounts();
          return listContas(mes);
        }

        var saida = <Conta>[];

        for (var conta in contas) {
          List<int> totalMovimentos = await _getTotalMovimentos(conta.id);
          var saldoResult = await _getSaldo(conta.id, mes);
          var banco = await _getBanco(conta.banco.id);

          if (banco.isLeft()) {
            return Left(Failure('Erro ao buscar o banco'));
          }

          if (saldoResult.isLeft()) {
            return Left(Failure('Erro ao processar o saldo da conta'));
          } else {
            conta = conta.copyWith(
              saldo: saldoResult.getOrElse(() => 0.0),
              totalDespesas: totalMovimentos.first,
              totalReceitas: totalMovimentos.last,
              banco: banco.getOrElse(() => Banco.fake()),
            );
            saida.add(conta);
          }
        }

        return Right(
            saida.where((conta) => conta.isArchived == false).toList());
      },
    );
  }

  Future<void> _generateDefaultAccounts() async {
    final bancos = await _bancoService.listBancos();

    if (bancos.isLeft()) {
      throw Exception('Não foi possível buscar os bancos');
    }

    var contasPadrao = [
      Conta(
        id: 1,
        nome: 'Salário',
        saldo: 0.0,
        saldoInicial: 0.0,
        totalDespesas: 0,
        totalReceitas: 0,
        banco: Banco.fake(),
        tipoConta: TipoConta.tipoContas.first,
        descricao: 'Conta salarial',
        color: Colors.blue,
      ),
    ];

    for (var conta in contasPadrao) {
      await _provider.saveConta(conta);
    }
  }

  Future<List<int>> _getTotalMovimentos(int contaId) async {
    var result = await _movimentoService.getTotalMovimentos(contaId);
    return result.getOrElse(() => [0, 0]);
  }

  @override
  Future<Either<Failure, int>> saveConta(Conta categoria) {
    return _provider.saveConta(categoria);
  }

  @override
  Future<Either<Failure, Conta>> getConta(int id) async {
    late Conta conta;

    final result = await _provider.getConta(id);
    if (result.isLeft()) {
      return Left(
          result.swap().getOrElse(() => Failure('Erro ao obter conta')));
    } else {
      conta = result.getOrElse(() => Conta.fake());
    }

    var saldoResult = await _getSaldo(id);
    var banco = await _getBanco(conta.banco.id);

    if (banco.isLeft()) {
      return Left(
          banco.swap().getOrElse(() => Failure('Erro ao buscar o banco')));
    }

    if (saldoResult.isLeft()) {
      return Left(Failure('Saldo inválido'));
    }

    conta = conta.copyWith(
      saldo: saldoResult.getOrElse(() => 0.0),
      banco: banco.getOrElse(() => Banco.fake()),
    );

    return Right(conta);
  }

  @override

  /// Calculates the monthly balance for the given month index.
  ///
  /// Args:
  ///   mesIndex: The month index (1-12) for which to calculate the balance.
  ///
  /// Returns:
  ///   A Future containing either a Failure object if an error occurs, or a BalancoMensal object representing the calculated balance.
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(
    int mesIndex,
  ) async {
    if (mesIndex < 1 || mesIndex > 12) {
      return Left(Failure('Mês inválido'));
    }

    var result = await _movimentoService.listMovimentos();

    if (result.isLeft()) {
      return Left(Failure(
          'Erro ao listar os movimentos no processamento do balanço mensal'));
    }

    var movimentos = result.getOrElse(() => []);

    var saldoReal = movimentos
        .where(
            (element) => element.data.month == mesIndex && element.confirmado)
        .fold(
      0.0,
      (previousValue, element) {
        if (element.tipoMovimentoId == 1) {
          return previousValue + element.valor;
        } else {
          return previousValue - element.valor;
        }
      },
    );

    var saldoContabilistico =
        movimentos.where((element) => element.data.month == mesIndex).fold(
      0.0,
      (previousValue, element) {
        if (element.tipoMovimentoId == 1) {
          return previousValue + element.valor;
        } else {
          return previousValue - element.valor;
        }
      },
    );

    return Right(
      BalancoMensal(
        saldoReal,
        saldoContabilistico,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> updateConta(Conta conta) {
    return _provider.updateConta(conta);
  }

  @override
  Future<Either<Failure, void>> deleteConta(int id) {
    return _provider.removeConta(id);
  }

  @override
  Future<Either<Failure, List<Conta>>> listArchivedContas() async {
    final result = await _provider.listContas();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.where((conta) => conta.isArchived == true).toList()),
    );
  }

  Future<Either<Failure, Banco>> _getBanco(int id) async {
    //! fix-me: isso pode ser melhorado
    await _bancoService.listBancos();
    var result = await _bancoService.getBanco(id);

    if (result.isLeft()) {
      return Left(Failure('Erro ao buscar o banco'));
    }

    return result;
  }

  Future<Either<Failure, double>> _getSaldo(int contaId, [int? mes]) async {
    var result = await _movimentoService.getSaldo(contaId, mes);

    return result;
  }
}
