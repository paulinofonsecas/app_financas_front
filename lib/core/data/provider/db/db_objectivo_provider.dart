import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/db/helpers/hive_db_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_objectivo_provider.dart';
import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class DBObjectivoProvider implements IObjectivoProvider {
  late final HiveDBProvider _dbProvider;

  DBObjectivoProvider(){
    _dbProvider = HiveDBProvider(boxName: kObjectivoBox);
  }

  @override
  Future<Either<Failure, Objectivo>> createObjectivo(
      Objectivo objectivo) async {
    try {
      await _dbProvider.add(objectivo.id, objectivo.toMap());
      return Right(objectivo);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteObjectivo(String objectivoId) async {
    try {
      await _dbProvider.delete(objectivoId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Objectivo>> getObjectivo(String objectivoId) async {
    try {
      final data = await _dbProvider.get(objectivoId);
      return data.fold(
        (l) => Left(l),
        (r) => Right(Objectivo.fromMap(r)),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivos() async {
    try {
      final data = await _dbProvider.list();
      return data.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => Objectivo.fromMap(e)).toList()),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Objectivo>> updateObjectivo(
      Objectivo objectivo) async {
    {
      try {
        await _dbProvider.add(objectivo.id, objectivo.toMap());
        return Right(objectivo);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    }
  }
}
