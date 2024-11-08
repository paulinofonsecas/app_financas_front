import 'package:app_financas/score/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/score/domain/entitys/conta.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IContaService  {
  Future<Either<Failure, Conta>> getConta(int id);
  Future<Either<Failure, void>> deleteConta(int id);
  Future<Either<Failure, List<Conta>>> listContas([int? mes]);
  Future<Either<Failure, List<Conta>>> listArchivedContas();
  Future<Either<Failure, int>> saveConta(Conta categoria);
  Future<Either<Failure, bool>> updateConta(Conta conta);
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(int mesIndex);
}