import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DBProvider {
  Future<void> initDb();
  Future<void> closeDb();
  Future<Either<Failure, void>> add(String id, Map<String, dynamic> data);
  Future<Either<Failure, void>> delete(String id);
  Future<Either<Failure, Map<String, dynamic>>> get(String id);
  Future<Either<Failure, List<Map<String, dynamic>>>> list();
}
