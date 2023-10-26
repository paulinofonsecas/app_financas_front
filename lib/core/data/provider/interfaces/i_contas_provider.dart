import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IContaProvider {
  Future<Either<Failure, List<Conta>>> listContas();
  Future<Either<Failure, bool>> saveConta(Conta categoria);
}
