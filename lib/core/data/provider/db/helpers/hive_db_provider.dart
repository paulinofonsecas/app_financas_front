import 'package:app_financas/core/data/provider/db/helpers/db_provider.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDBProvider implements DBProvider {
  final String boxName;
  late Box<Map<dynamic, dynamic>> _planejamentoBox;

  HiveDBProvider({required this.boxName});

  @override
  Future<void> initDb() async {
    _planejamentoBox = await Hive.openBox(boxName);

    return;
  }

  @override
  Future<void> closeDb() {
    return _planejamentoBox.close();
  }

  @override
  Future<Either<Failure, void>> add(String id, Map<String, dynamic> data) async {
    try {
      await initDb();
      _planejamentoBox.put(id, data);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await _planejamentoBox.delete(id);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> get(String id) async {
    try {
      return Future.value(
          Right(_planejamentoBox.get(id)! as Map<String, dynamic>));
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> list() {
    try {
      return Future.value(Right(
          _planejamentoBox.values.toList().cast<Map<String, dynamic>>()));
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }
}
