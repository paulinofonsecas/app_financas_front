import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/balanco_mensal.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/repositories/i_conta_repository.dart';

import 'package:dartz/dartz.dart';

abstract class IContaUseCases {
  Future<Either<Failure, Conta>> getConta(int id);
  Future<Either<Failure, void>> deleteConta(int id);
  Future<Either<Failure, void>> arquivarConta(int id);
  Future<Either<Failure, void>> desarquivarConta(int id);
  Future<Either<Failure, List<Conta>>> listContas([int? mes]);
  Future<Either<Failure, List<Conta>>> listArchivedContas();
  Future<Either<Failure, int>> saveConta(Conta categoria);
  Future<Either<Failure, bool>> updateConta(Conta conta);
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(int mesIndex);
}

class ContaUseCases implements IContaUseCases {
  final IContaRepository _repository;

  ContaUseCases(this._repository);

  @override
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(int mesIndex) {
    return _repository.calcularBalancoMensal(mesIndex);
  }

  @override
  Future<Either<Failure, void>> deleteConta(int id) {
    return _repository.deleteConta(id);
  }

  @override
  Future<Either<Failure, Conta>> getConta(int id) {
    return _repository.getConta(id);
  }

  @override
  Future<Either<Failure, List<Conta>>> listArchivedContas() {
    return _repository.listArchivedContas();
  }

  @override
  Future<Either<Failure, List<Conta>>> listContas([int? mes]) {
    return _repository.listContas(mes);
  }

  @override
  Future<Either<Failure, int>> saveConta(Conta categoria) {
    return _repository.saveConta(categoria);
  }

  @override
  Future<Either<Failure, bool>> updateConta(Conta conta) {
    return _repository.updateConta(conta);
  }

  @override
  Future<Either<Failure, void>> arquivarConta(int id) {
    return _repository.arquivarConta(id);
  }

  @override
  Future<Either<Failure, void>> desarquivarConta(int id) {
    return _repository.desarquivarConta(id);
  }
}
