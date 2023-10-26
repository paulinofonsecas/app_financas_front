import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class SaldosService implements ISaldosService {
  final IMovimentoService movimentoService;

  SaldosService(this.movimentoService);

  @override
  Future<Either<Failure, double>> getEntradas() async {
    var list = _getList(await movimentoService.listMovimentos());

    var result = list
        .where((element) => element.tipoMovimentoId == 1)
        .fold(0.0, (sum, element) => sum + element.valor);

    return Right(result);
  }

  @override
  Future<Either<Failure, double>> getSaidas() async {
    var list = _getList(await movimentoService.listMovimentos());

    var result = list
        .where((element) => element.tipoMovimentoId == 2)
        .fold(0.0, (sum, element) => sum + element.valor);

    return Right(result);
  }

  @override
  Future<Either<Failure, double>> getSaldoDisponivel() async {
    var entradas = (await getEntradas()).getOrElse(() => 0.0);
    var saidas = (await getSaidas()).getOrElse(() => 0.0);

    return Right(entradas - saidas);
  }

  List<Movimento> _getList(Either<Failure, List<Movimento>> result) {
    return result.getOrElse(() => []);
  }
}
