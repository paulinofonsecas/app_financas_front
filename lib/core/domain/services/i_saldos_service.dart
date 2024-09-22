import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ISaldosService {
  Future<Either<Failure, double>> getSaldoDisponivel();
  Future<Either<Failure, double>> getEntradas();
  Future<Either<Failure, double>> getSaidas();
  Future<Either<Failure, double>> getEntradasByConta(int contaId);
  Future<Either<Failure, double>> getSaidasByConta(int contaId);
}
