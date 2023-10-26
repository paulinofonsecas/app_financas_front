import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/erros/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../interfaces/i_contas_provider.dart';

class DbContaProvider implements IContaProvider {
  late Box<Map<dynamic, dynamic>> _contas;

  Future<void> initDb() async {
    _contas = await Hive.openBox(kContasBox);
  }

  @override
  Future<Either<Failure, bool>> saveConta(
    Conta categoria,
  ) async {
    try {
      await initDb();

      var map = categoria.toMap();
      var lastId = _contas.values.length + 1;
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
      return const Right([]);
    }

    return Right(
      result.values
          .map((e) => Conta.fromMap(e.cast<String, dynamic>()))
          .toList(),
    );
  }
}
