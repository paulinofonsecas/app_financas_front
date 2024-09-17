import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IObjectivoProvider {
  Future<Either<Failure, Objectivo>> createObjectivo(Objectivo objectivo);
  Future<Either<Failure, Objectivo>> updateObjectivo(Objectivo objectivo);
  Future<Either<Failure, void>> deleteObjectivo(String objectivoId);
  Future<Either<Failure, Objectivo>> getObjectivo(String objectivoId);
  Future<Either<Failure, List<Objectivo>>> listObjectivos();
}
