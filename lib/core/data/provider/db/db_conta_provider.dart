import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/erros/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../interfaces/i_contas_provider.dart';

class DbContaProvider implements IContaProvider {
  final IMovimentoProvider movimentoProvider;
  late Box<Map<dynamic, dynamic>> _contas;

  DbContaProvider(this.movimentoProvider);

  Future<void> initDb() async {
    _contas = await Hive.openBox(kContasBox);
  }

  @override
  Future<Either<Failure, bool>> saveConta(
    Conta conta,
  ) async {
    try {
      await initDb();

      var lastId = _contas.values.length + 1;
      conta = conta.copyWith(id: lastId);
      var map = conta.toMap();
      await _contas.put(lastId, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, List<Conta>>> listContas() async {
    await initDb();
    var result = _contas.toMap();

    if (result.isEmpty) {
      var contasPadrao = [
        'Familiar',
        'Empresa',
        'Gastos gerais',
        'Poupanças',
        'Outro',
      ];

      for (var cont in contasPadrao) {
        await saveConta(Conta(nome: cont, saldo: 0.0, id: -1));
      }
      return listContas();
    }

    var saida = <Conta>[];
    var contas = result.values
        .map((e) => Conta.fromMap(e.cast<String, dynamic>()))
        .toList();

    for (var conta in contas) {
      var saldoResult = await _getSaldo(conta.id);

      if (saldoResult.isLeft()) {
        return Left(Failure('Erro ao processar o saldo da conta'));
      } else {
        conta = conta.copyWith(saldo: saldoResult.getOrElse(() => 0.0));
        saida.add(conta);
      }
    }

    return Right(saida);
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

      if (saldoResult.isLeft()) {
        return Left(Failure('Saldo inválido'));
      } else {
        conta = conta.copyWith(saldo: saldoResult.getOrElse(() => 0.0));
      }
      return Right(conta);
    }
  }

  Future<Either<Failure, double>> _getSaldo(int contaId) async {
    var result = await movimentoProvider.getSaldo(contaId);

    return result;
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
}
