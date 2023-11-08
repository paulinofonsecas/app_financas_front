import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IContaProvider {
  Future<Either<Failure, Conta>> getConta(int id);
  Future<Either<Failure, List<Conta>>> listContas();
  Future<Either<Failure, bool>> saveConta(Conta conta);
  Future<Either<Failure, bool>> updateConta(Conta conta);
}
