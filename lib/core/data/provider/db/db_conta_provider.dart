import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_banco_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/tipo_conta.dart';
import 'package:app_financas/core/erros/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../interfaces/i_contas_provider.dart';

class DbContaProvider implements IContaProvider {
  final IMovimentoProvider movimentoProvider;
  final IBancoProvider _bancoProvider;
  late Box<Map<dynamic, dynamic>> _contas;

  DbContaProvider(this.movimentoProvider, this._bancoProvider);

  Future<void> initDb() async {
    _contas = await Hive.openBox(kContasBox);
  }

  @override
  Future<Either<Failure, int>> saveConta(
    Conta conta,
  ) async {
    try {
      await initDb();

      var lastId = _contas.values.length + 1;
      conta = conta.copyWith(id: lastId);
      var map = conta.toMap();
      await _contas.put(lastId, map);
      return Right(lastId);
    } catch (e) {
      return const Right(-1);
    }
  }

  @override
  Future<Either<Failure, List<Conta>>> listContas([int? mes]) async {
    await initDb();
    var result = _contas.toMap();

    if (result.isEmpty) {
      await _generateDefaultAccounts();

      return listContas();
    }

    var saida = <Conta>[];
    var contas = result.values
        .map((e) => Conta.fromMap(e.cast<String, dynamic>()))
        .toList();

    for (var conta in contas) {
      var saldoResult = await _getSaldo(conta.id, mes);
      List<int> totalMovimentos = await _getTotalMovimentos(conta.id);
      var banco = await _getBanco(conta.banco.id);

      if (saldoResult.isLeft()) {
        return Left(Failure('Erro ao processar o saldo da conta'));
      } else {
        conta = conta.copyWith(
          saldo: saldoResult.getOrElse(() => 0.0),
          totalDespesas: totalMovimentos.first,
          totalReceitas: totalMovimentos.last,
          banco: banco,
        );
        saida.add(conta);
      }
    }

    return Right(saida);
  }

  Future<void> _generateDefaultAccounts() async {
    var contasPadrao = [
      Conta(
        id: 1,
        nome: 'Carteira',
        saldo: 0.0,
        saldoInicial: 0.0,
        totalDespesas: 0,
        totalReceitas: 0,
        banco: Banco.fake(),
        tipoConta: TipoConta.tipoContas.first,
        descricao: 'Conta de gastos diversos',
        color: Colors.orangeAccent,
      ),
      Conta(
        id: 2,
        nome: 'Salário',
        saldo: 0.0,
        saldoInicial: 0.0,
        totalDespesas: 0,
        totalReceitas: 0,
        banco: Banco.fake(),
        tipoConta: TipoConta.tipoContas.first,
        descricao: 'Conta salarial',
        color: Colors.brown,
      ),
      Conta(
        id: 3,
        nome: 'Pupança',
        saldo: 0.0,
        saldoInicial: 0.0,
        totalDespesas: 0,
        totalReceitas: 0,
        banco: Banco.fake(),
        tipoConta: TipoConta.tipoContas.first,
        descricao: 'Conta de pupança à curto prazo',
        color: Colors.blueAccent,
      ),
    ];

    for (var conta in contasPadrao) {
      await saveConta(conta);
    }
  }

  @override
  Future<Either<Failure, Conta>> getConta(int id) async {
    await initDb();

    var data = _contas.get(id);

    if (data == null) {
      return Left(NotFoundError('Conta não encontrada'));
    } else {
      var conta = Conta.fromMap(data.cast<String, dynamic>());
      var saldoResult = await _getSaldo(id);
      var banco = await _getBanco(conta.banco.id);

      if (saldoResult.isLeft()) {
        return Left(Failure('Saldo inválido'));
      } else {
        conta = conta.copyWith(
          saldo: saldoResult.getOrElse(() => 0.0),
          banco: banco,
        );
      }
      return Right(conta);
    }
  }

  Future<Banco> _getBanco(int id) async {
    await _bancoProvider.listBancos();
    var result = await _bancoProvider.getBanco(id);
    return result.getOrElse(() => Banco.fake());
  }

  Future<Either<Failure, double>> _getSaldo(int contaId, [int? mes]) async {
    var result = await movimentoProvider.getSaldo(contaId, mes);

    return result;
  }

  Future<List<int>> _getTotalMovimentos(int contaId) async {
    var result = await movimentoProvider.getTotalMovimentos(contaId);
    return result.getOrElse(() => [0, 0]);
  }

  @override
  Future<Either<Failure, bool>> updateConta(Conta conta) async {
    try {
      await initDb();

      var map = conta.toMap();
      await _contas.put(conta.id, map);

      return const Right(true);
    } catch (e) {
      return Left(DbException('Erro ao atualizar conta'));
    }
  }

  @override
  Future<Either<Failure, void>> removeConta(int id) async {
    await initDb();

    try {
      await _contas.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(DbException('Erro ao remover conta'));
    }
  }
}
