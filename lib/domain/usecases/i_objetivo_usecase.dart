import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/objectivo.dart';
import 'package:app_financas/domain/repositories/i_objetivo_repository.dart';

import 'package:dartz/dartz.dart';

abstract class IObjectivoUseCases {
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

class ObjectivoUseCases implements IObjectivoUseCases {
  final IObjectivoRepository repository;

  ObjectivoUseCases(this.repository);

  @override
  Future<Either<Failure, bool>> adicionarFundo(
      Objectivo objectivo, double fundo) {
    return repository.adicionarFundo(objectivo, fundo);
  }

  @override
  Future<Either<Failure, Objectivo>> createObjectivo(Objectivo objectivo) {
    return repository.createObjectivo(objectivo);
  }

  @override
  Future<Either<Failure, void>> deleteObjectivo(String objectivoId) {
    return repository.deleteObjectivo(objectivoId);
  }

  @override
  Future<Either<Failure, Objectivo>> getObjectivo(String objectivoId) {
    return repository.getObjectivo(objectivoId);
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivos() {
    return repository.listObjectivos();
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivosFinalizados() {
    return repository.listObjectivosFinalizados();
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivosPausados() {
    return repository.listObjectivosPausados();
  }

  @override
  Future<Either<Failure, Objectivo>> updateObjectivo(Objectivo objectivo) {
    return repository.updateObjectivo(objectivo);
  }
}
