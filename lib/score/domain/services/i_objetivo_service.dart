import 'package:app_financas/score/domain/entitys/objectivo.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IObjectivoService {
  Future<Either<Failure, Objectivo>> createObjectivo(Objectivo objectivo);
  Future<Either<Failure, Objectivo>> updateObjectivo(Objectivo objectivo);
  Future<Either<Failure, void>> deleteObjectivo(String objectivoId);
  Future<Either<Failure, Objectivo>> getObjectivo(String objectivoId);
  Future<Either<Failure, List<Objectivo>>> listObjectivos();
  Future<Either<Failure, List<Objectivo>>> listObjectivosPausados();
  Future<Either<Failure, List<Objectivo>>> listObjectivosFinalizados();
  Future<Either<Failure, bool>> adicionarFundo(
      Objectivo objectivo, double fundo);
}
