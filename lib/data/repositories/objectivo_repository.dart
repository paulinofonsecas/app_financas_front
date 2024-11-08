import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/objectivo.dart';
import 'package:app_financas/domain/repositories/i_objetivo_repository.dart';
import 'package:app_financas/data/datasources/interfaces/i_objectivo_provider.dart';

import 'package:dartz/dartz.dart';

class ObjectivoRepository implements IObjectivoRepository {
  final IObjectivoProvider _provider;

  ObjectivoRepository(this._provider);

  @override
  Future<Either<Failure, Objectivo>> createObjectivo(Objectivo objectivo) {
    return _provider.createObjectivo(objectivo);
  }

  @override
  Future<Either<Failure, void>> deleteObjectivo(String objectivoId) {
    return _provider.deleteObjectivo(objectivoId);
  }

  @override
  Future<Either<Failure, Objectivo>> getObjectivo(String objectivoId) {
    return _provider.getObjectivo(objectivoId);
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivos() {
    return _provider.listObjectivos();
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivosFinalizados() async {
    final objectivosResult = await _provider.listObjectivos();

    return objectivosResult.fold(
      (failure) => left(failure),
      (objectivos) => right(objectivos
          .where((obj) =>
              obj.currentValue >= obj.targetValue &&
              obj.currentValue != 0 &&
              !obj.isPaused)
          .toList()),
    );
  }

  @override
  Future<Either<Failure, List<Objectivo>>> listObjectivosPausados() async {
    final objectivosResult = await _provider.listObjectivos();

    return objectivosResult.fold(
      (failure) => left(failure),
      (objectivos) => right(objectivos.where((obj) => obj.isPaused).toList()),
    );
  }

  @override
  Future<Either<Failure, Objectivo>> updateObjectivo(Objectivo objectivo) {
    return _provider.updateObjectivo(objectivo);
  }

  @override
  Future<Either<Failure, bool>> adicionarFundo(
      Objectivo objectivo, double fundo) async {
    if (fundo <= 0) {
      return right(false);
    }

    final objectivoResult = await _provider.updateObjectivo(
      objectivo.copyWith(currentValue: objectivo.currentValue + fundo),
    );

    return objectivoResult.fold(
      (failure) => left(failure),
      (objectivo) => right(true),
    );
  }
}
