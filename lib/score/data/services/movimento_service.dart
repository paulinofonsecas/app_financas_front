import 'package:app_financas/score/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/score/domain/services/i_movimento_service.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../domain/entitys/movimento.dart';
import '../provider/interfaces/i_movimento_provider.dart';

class MovimentoService implements IMovimentoService {
  final IMovimentoProvider _provider;
  bool isLocal = false;

  MovimentoService({required IMovimentoProvider provider})
      : _provider = provider {
    var sc = Get.find<SetupConfiguration>();
    isLocal = sc.isLocal;
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() {
    return _provider.listMovimentos();
  }

  @override
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento) {
    return _provider.saveMovimento(movimento);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date) {
    return _provider.listMovimentosAt(date);
  }

  @override
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) {
    return _provider.editMovimento(movimento);
  }

  @override
  Future<Either<Failure, Movimento>> getMovimento(int id) {
    return _provider.getMovimento(id);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(
    int page,
    int pageSize,
  ) {
    if (isLocal) {
      return _getLocalPaginatedMovimentos(page, pageSize);
    } else {
      return _provider.listPaginatedMovimentos(page, pageSize);
    }
  }

  Future<Either<Failure, List<Movimento>>> _getLocalPaginatedMovimentos(
    int page,
    int pageSize,
  ) {
    return _provider.listMovimentos().then((value) {
      if (value.isLeft()) {
        return const Right([]);
      } else {
        var list = value.getOrElse(() => [])
          ..sort((a, b) => a.data.compareTo(b.data));
        list = list.reversed.toList();

        var result = paginatedList(list, page, pageSize);
        return Right(result);
      }
    });
  }

  List<Movimento> paginatedList(List<Movimento> list, int page,
      [int pageSize = 10]) {
    if (page == 1) {
      return list.take(pageSize).toList();
    } else {
      return list.skip(pageSize * page).take(pageSize).toList();
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMovimento(int id) {
    return _provider.deleteMovimento(id);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedContaMovimentos(
      int contaId, int page, int pageSize) async {
    var result = await listPaginatedMovimentos(page, pageSize);

    if (result.isRight()) {
      var list = result.getOrElse(() => []);
      list = list.where((element) => element.cartaoId == contaId).toList();
      return Right(list);
    } else {
      return result;
    }
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosEntrada(
      {DateTime? date}) {
    return _provider.listMovimentosEntrada(date: date);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosSaida(
      {DateTime? date}) {
    return _provider.listMovimentosSaida(date: date);
  }

  @override
  Future<Either<Failure, List<Movimento>>> transferirMovimentos(
      List<Movimento> movimentos, int destinoId) {
    return _provider.transferirMovimentos(movimentos, destinoId);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosPendentes() async {
    final result = await _provider.listMovimentos();

    if (result.isRight()) {
      final listMovimentos = result.getOrElse(() => []);
      return Right(
        listMovimentos.where((element) => !element.confirmado).toList(),
      );
    } else {
      return result;
    }
  }

  @override
  void addListener(Function fn) {
    _provider.addListener(fn);
  }

  @override
  void removeListener(Function fn) {
    _provider.removeListener(fn);
  }

  @override
  Future<Either<Failure, double>> getSaldo(int contaId, [int? mes]) async {
    var result = await _provider.listMovimentos();

    if (result.isLeft()) {
      return Left(Failure('Erro ao processar o saldo da conta'));
    }

    var movimentos = result
        .getOrElse(() => [])
        .where((element) => element.confirmado && element.cartaoId == contaId);

    if (mes != null) {
      movimentos = movimentos
          .where((element) => element.data.month == mes && element.confirmado);
    }

    var entradas = 0.0;
    var saidas = 0.0;

    for (var mov in movimentos) {
      if (mov.tipoMovimentoId == 1) {
        entradas += mov.valor;
      } else {
        saidas += mov.valor;
      }
    }

    var saldo = entradas - saidas;

    return Right(saldo);
  }

  @override
  Future<Either<Failure, List<int>>> getTotalMovimentos(int contaId) async {
    var result = await listMovimentos();

    if (result is Right) {
      var movimentos = result
          .getOrElse(() => [])
          .where((element) => element.confirmado)
          .where((element) => element.cartaoId == contaId)
          .toList();

      var entradas = 0;
      var saidas = 0;

      for (var mov in movimentos) {
        if (mov.confirmado && mov.tipoMovimentoId == 1) {
          entradas++;
        } else if (mov.confirmado && mov.tipoMovimentoId == 2) {
          saidas++;
        }
      }

      return Right([saidas, entradas]);
    } else {
      return Left(Failure('Erro ao processar o total de movimentos'));
    }
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosDaSemana() async {
    final result = await _provider.listMovimentos();
    final now = DateTime.now();

    return result.fold(
        (l) => Left(l),
        (r) => Right(r
            .where((element) => element.data.weekday == now.weekday)
            .toList()));
  }
}
