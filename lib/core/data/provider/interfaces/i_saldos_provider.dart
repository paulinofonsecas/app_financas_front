import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ISaldosProvider {
  Future<Either<Failure, double>> getSaldoDisponivel();
  Future<Either<Failure, double>> getEntradas();
  Future<Either<Failure, double>> getSaidas();
}
