import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/balanco_mensal.dart';
import 'package:app_financas/domain/entities/conta.dart';

import 'package:dartz/dartz.dart';

abstract class IContaRepository {
  Future<Either<Failure, Conta>> getConta(int id);
  Future<Either<Failure, void>> deleteConta(int id);
  Future<Either<Failure, List<Conta>>> listContas([int? mes]);
  Future<Either<Failure, List<Conta>>> listArchivedContas();
  Future<Either<Failure, int>> saveConta(Conta categoria);
  Future<Either<Failure, bool>> updateConta(Conta conta);
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(int mesIndex);
  Future<Either<Failure, void>> arquivarConta(int id);
  Future<Either<Failure, void>> desarquivarConta(int id);
}
