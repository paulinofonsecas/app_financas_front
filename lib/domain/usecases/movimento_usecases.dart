import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/repositories/i_movimento_repository.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:dartz/dartz.dart';

class MovimentoUsecases implements IMovimentoUseCases {
  final IMovimentoRepository _repository;

  MovimentoUsecases(this._repository);

  @override
  void addListener(Function fn) {
    // TODO: implement addListener
  }

  @override
  Future<Either<Failure, bool>> deleteMovimento(int id) {
    return _repository.deleteMovimento(id);
  }

  @override
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) {
    return _repository.editMovimento(movimento);
  }

  @override
  Future<Either<Failure, Movimento>> getMovimento(int id) {
    return _repository.getMovimento(id);
  }

  @override
  Future<Either<Failure, double>> getSaldo(int contaId, [int? mes]) {
    return _repository.getSaldo(contaId, mes);
  }

  @override
  Future<Either<Failure, List<int>>> getTotalMovimentos(int contaId) {
    return _repository.getTotalMovimentos(contaId);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() {
    return _repository.listMovimentos();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date) {
    return _repository.listMovimentosAt(date);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosDaSemana() {
    return _repository.listMovimentosDaSemana();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosEntrada(
      {DateTime? date}) {
    return _repository.listMovimentosEntrada(date: date);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosPendentes() {
    return _repository.listMovimentosPendentes();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosSaida(
      {DateTime? date}) {
    return _repository.listMovimentosSaida(date: date);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedContaMovimentos(
      int currentIndex, int page, int pageSize) {
    return _repository.listPaginatedContaMovimentos(
        currentIndex, page, pageSize);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(
      int page, int pageSize) {
    return _repository.listPaginatedMovimentos(page, pageSize);
  }

  @override
  void removeListener(Function fn) {
    // TODO: implement removeListener
  }

  @override
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento) {
    return _repository.saveMovimento(movimento);
  }

  @override
  Future<Either<Failure, List<Movimento>>> transferirMovimentos(
      List<Movimento> movimentos, int destinoId) {
    return _repository.transferirMovimentos(movimentos, destinoId);
  }
}
