import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/repositories/i_saldos_repository.dart';
import 'package:dartz/dartz.dart';

abstract class ISaldosUseCases {
  Future<Either<Failure, double>> getSaldoDisponivel();
  Future<Either<Failure, double>> getEntradas();
  Future<Either<Failure, double>> getSaidas();
  Future<Either<Failure, double>> getEntradasByConta(int contaId);
  Future<Either<Failure, double>> getSaidasByConta(int contaId);
}

class SaldosUseCases implements ISaldosUseCases {
  final ISaldosRepository _repository;

  SaldosUseCases(this._repository);

  @override
  Future<Either<Failure, double>> getEntradas() {
    return _repository.getEntradas();
  }

  @override
  Future<Either<Failure, double>> getEntradasByConta(int contaId) {
    return _repository.getEntradasByConta(contaId);
  }

  @override
  Future<Either<Failure, double>> getSaidas() {
    return _repository.getSaidas();
  }

  @override
  Future<Either<Failure, double>> getSaidasByConta(int contaId) {
    return _repository.getSaidasByConta(contaId);
  }

  @override
  Future<Either<Failure, double>> getSaldoDisponivel() {
    return _repository.getSaldoDisponivel();
  }
}
