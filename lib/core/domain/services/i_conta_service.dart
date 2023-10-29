import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IContaService  {
  Future<Either<Failure, List<Conta>>> listContas();
  Future<Either<Failure, bool>> saveConta(Conta categoria);
}