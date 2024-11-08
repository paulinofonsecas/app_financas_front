import 'package:app_financas/score/domain/entitys/conta.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IContaProvider {
  Future<Either<Failure, Conta>> getConta(int id);
  Future<Either<Failure, void>> removeConta(int id);
  Future<Either<Failure, List<Conta>>> listContas([int? mes]);
  Future<Either<Failure, int>> saveConta(Conta conta);
  Future<Either<Failure, bool>> updateConta(Conta conta);
}
