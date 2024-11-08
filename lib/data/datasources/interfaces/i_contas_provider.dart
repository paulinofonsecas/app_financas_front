import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/conta.dart';

import 'package:dartz/dartz.dart';

abstract class IContaProvider {
  Future<Either<Failure, Conta>> getConta(int id);
  Future<Either<Failure, void>> removeConta(int id);
  Future<Either<Failure, List<Conta>>> listContas([int? mes]);
  Future<Either<Failure, int>> saveConta(Conta conta);
  Future<Either<Failure, bool>> updateConta(Conta conta);
  Future<Either<Failure, void>> desarquivarConta(int id);
  Future<Either<Failure, void>> arquivarConta(int id);
}
