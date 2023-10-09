import 'package:app_financas/core/data/provider/interfaces/i_saldos_provider.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class SaldosService implements ISaldosService {
  final ISaldosProvider provider;

  SaldosService(this.provider);

  @override
  Future<Either<Failure, double>> getEntradas() {
    return provider.getEntradas();
  }

  @override
  Future<Either<Failure, double>> getSaidas() {
    return provider.getSaidas();
  }

  @override
  Future<Either<Failure, double>> getSaldoDisponivel() {
    return provider.getSaldoDisponivel();
  }
}
