import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IPlanejamentoService {
  Future<Either<Failure, Planejamento>> createPlanejamento(
      Planejamento planejamento);
  Future<Either<Failure, Planejamento>> updatePlanejamento(
      Planejamento planejamento);
  Future<Either<Failure, void>> deletePlanejamento(
      String planejamentoId);
  Future<Either<Failure, List<Planejamento>>> listPlanejamentos();
  Future<Either<Failure, Planejamento>> getPlanejamento(String planejamentoId);
  Future<Either<Failure, Planejamento>> getPlanejamentoOn(DateTime date);
  Future<Either<Failure, Planejamento>> getPlanejamentoAtual();
}
