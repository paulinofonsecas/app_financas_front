import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class ContaService implements IContaService {
  final IContaProvider provider;

  ContaService(this.provider);

  @override
  Future<Either<Failure, List<Conta>>> listContas([int? mes]) async {
    final result = await provider.listContas(mes);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.where((conta) => conta.isArchived == false).toList()),
    );
  }

  @override
  Future<Either<Failure, int>> saveConta(Conta categoria) {
    return provider.saveConta(categoria);
  }

  @override
  Future<Either<Failure, Conta>> getConta(int id) {
    return provider.getConta(id);
  }

  @override
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(int mesIndex) {
    return provider.calcularBalancoMensal(mesIndex);
  }

  @override
  Future<Either<Failure, bool>> updateConta(Conta conta) {
    return provider.updateConta(conta);
  }

  @override
  Future<Either<Failure, void>> deleteConta(int id) {
    return provider.removeConta(id);
  }

  @override
  Future<Either<Failure, List<Conta>>> listArchivedContas() async {
    final result = await provider.listContas();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r.where((conta) => conta.isArchived == true).toList()),
    );
  }
}
