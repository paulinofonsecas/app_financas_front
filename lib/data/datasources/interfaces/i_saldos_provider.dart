import 'package:app_financas/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ISaldosProvider {
  Future<Either<Failure, double>> getEntradasByConta(int contaId);
  Future<Either<Failure, double>> getSaidasByConta(int contaId);
  Future<Either<Failure, double>> getSaldoDisponivel();
  Future<Either<Failure, double>> getEntradas();
  Future<Either<Failure, double>> getSaidas();
}
