import 'package:app_financas/core/data/provider/interfaces/i_objectivo_provider.dart';
import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/domain/services/i_objetivo_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class ObjectivoService implements IObjectivoService {
  final IObjectivoProvider _provider;

  ObjectivoService(this._provider);

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
              obj.currentValue == obj.targetValue &&
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
}
