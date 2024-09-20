import 'package:app_financas/core/data/provider/db/helpers/db_provider.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDBProvider implements DBProvider {
  final String boxName;
  late Box<Map<dynamic, dynamic>> _objectivoBox;

  HiveDBProvider({required this.boxName});

  @override
  Future<void> initDb() async {
    _objectivoBox = await Hive.openBox(boxName);
    return;
  }

  @override
  Future<void> closeDb() {
    return _objectivoBox.close();
  }

  @override
  Future<Either<Failure, void>> add(
      String id, Map<String, dynamic> data) async {
    try {
      await initDb();
      _objectivoBox.put(id, data);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await initDb();
      await _objectivoBox.delete(id);
      return const Right(null);
    } catch (e) {
      await closeDb();
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> get(String id) async {
    try {
      await initDb();
      return Right(_objectivoBox.get(id)!.cast<String, dynamic>());
    } catch (e) {
      await closeDb();
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> list() async {
    try {
      await initDb();
      final raw = _objectivoBox.values
          .toList()
          .map((e) => e.cast<String, dynamic>())
          .toList();
      return Right(raw);
    } catch (e) {
      await closeDb();
      return Left(Failure(e.toString()));
    }
  }
}
