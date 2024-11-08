import 'package:app_financas/score/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/score/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/score/domain/entitys/conta.dart';
import 'package:app_financas/score/erros/failure.dart';
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

  Future<void> closeDb() async {
    await _contas.close();
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

    var contas = result.values
        .map((e) => Conta.fromMap(e.cast<String, dynamic>()))
        .toList();

    return Right(contas);
  }

  @override
  Future<Either<Failure, Conta>> getConta(int id) async {
    await initDb();

    var data = _contas.get(id);

    if (data == null) {
      return Left(NotFoundError('Conta não encontrada'));
    } else {
      var conta = Conta.fromMap(data.cast<String, dynamic>());
      return Right(conta);
    }
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
