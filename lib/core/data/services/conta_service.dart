import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class ContaService implements IContaService {
  final IContaProvider provider;

  ContaService(this.provider);

  @override
  Future<Either<Failure, List<Conta>>> listContas() {
    return provider.listContas();
  }

  @override
  Future<Either<Failure, bool>> saveConta(Conta categoria) {
    return provider.saveConta(categoria);
  }

  @override
  Future<Either<Failure, Conta>> getConta(int id) {
    return provider.getConta(id);
  }
}
