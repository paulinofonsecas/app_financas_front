import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/planejamento.dart';

import 'package:dartz/dartz.dart';

abstract class IPlanejamentoProvider {
  Future<Either<Failure, Planejamento>> createPlanejamento(
      Planejamento planejamento);
  Future<Either<Failure, Planejamento>> updatePlanejamento(
      Planejamento planejamento);
  Future<Either<Failure, void>> deletePlanejamento(String planejamentoId);
  Future<Either<Failure, Planejamento>> getPlanejamento(String planejamentoId);
  Future<Either<Failure, List<Planejamento>>> getAllPlanejamentos(
      {DateTime? dataReferencia});
}
