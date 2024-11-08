import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/banco.dart';
import 'package:app_financas/domain/repositories/i_banco_repository.dart';

import 'package:dartz/dartz.dart';

abstract class IBancoUseCases {
  Future<Either<Failure, List<Banco>>> listBancos();
  Future<Either<Failure, Banco>> getBanco(int id);
}

class BancoUseCases implements IBancoUseCases {
  final IBancoRepository _repository;

  BancoUseCases(this._repository);

  @override
  Future<Either<Failure, Banco>> getBanco(int id) {
    return _repository.getBanco(id);
  }

  @override
  Future<Either<Failure, List<Banco>>> listBancos() {
    return _repository.listBancos();
  }
}
