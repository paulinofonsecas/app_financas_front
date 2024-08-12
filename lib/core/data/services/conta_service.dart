import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class ContaService implements IContaService {
  final IContaProvider provider;
  final IMovimentoService _movimentoService;

  ContaService(this.provider, this._movimentoService);

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

  /// Calculates the monthly balance for the given month index.
  ///
  /// Args:
  ///   mesIndex: The month index (1-12) for which to calculate the balance.
  ///
  /// Returns:
  ///   A Future containing either a Failure object if an error occurs, or a BalancoMensal object representing the calculated balance.
  Future<Either<Failure, BalancoMensal>> calcularBalancoMensal(
    int mesIndex,
  ) async {
    if (mesIndex < 1 || mesIndex > 12) {
      return Left(Failure('Mês inválido'));
    }

    var result = await _movimentoService.listMovimentos();

    if (result.isLeft()) {
      return Left(Failure('Erro ao listar os movimentos no processamento do balanço mensal'));
    }

    var movimentos = result.getOrElse(() => []);

    var saldoReal = movimentos
        .where(
            (element) => element.data.month == mesIndex && element.confirmado)
        .fold(
      0.0,
      (previousValue, element) {
        if (element.tipoMovimentoId == 1) {
          return previousValue + element.valor;
        } else {
          return previousValue - element.valor;
        }
      },
    );

    var saldoContabilistico =
        movimentos.where((element) => element.data.month == mesIndex).fold(
      0.0,
      (previousValue, element) {
        if (element.tipoMovimentoId == 1) {
          return previousValue + element.valor;
        } else {
          return previousValue - element.valor;
        }
      },
    );

    return Right(
      BalancoMensal(
        saldoReal,
        saldoContabilistico,
      ),
    );
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
