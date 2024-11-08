import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:app_financas/domain/repositories/i_planejamento_repository.dart';

import 'package:dartz/dartz.dart';

abstract class IPlanejamentoUseCases {
  Future<Either<Failure, Planejamento>> createPlanejamento(
    Planejamento planejamento,
  );
  Future<Either<Failure, Planejamento>> updatePlanejamento(
    Planejamento planejamento,
  );
  Future<Either<Failure, void>> deletePlanejamento(String planejamentoId);
  Future<Either<Failure, void>> deletePlanejamentoAtual();
  Future<Either<Failure, List<Planejamento>>> listPlanejamentos();
  Future<Either<Failure, Planejamento>> getPlanejamento(String planejamentoId);
  Future<Either<Failure, Planejamento>> getPlanejamentoOn(DateTime date);
  Future<Either<Failure, Planejamento>> getPlanejamentoAtual();
}

class PlanejamentoUseCases implements IPlanejamentoUseCases {
  final IPlanejamentoRepository repository;

  PlanejamentoUseCases(this.repository);

  @override
  Future<Either<Failure, Planejamento>> createPlanejamento(
      Planejamento planejamento) {
    return repository.createPlanejamento(planejamento);
  }

  @override
  Future<Either<Failure, void>> deletePlanejamento(String planejamentoId) {
    return repository.deletePlanejamento(planejamentoId);
  }

  @override
  Future<Either<Failure, void>> deletePlanejamentoAtual() {
    return repository.deletePlanejamentoAtual();
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamento(String planejamentoId) {
    return repository.getPlanejamento(planejamentoId);
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamentoAtual() {
    return repository.getPlanejamentoAtual();
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamentoOn(DateTime date) {
    return repository.getPlanejamentoOn(date);
  }

  @override
  Future<Either<Failure, List<Planejamento>>> listPlanejamentos() {
    return repository.listPlanejamentos();
  }

  @override
  Future<Either<Failure, Planejamento>> updatePlanejamento(
      Planejamento planejamento) {
    return repository.updatePlanejamento(planejamento);
  }
}
