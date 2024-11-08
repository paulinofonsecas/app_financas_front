import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/movimento.dart';

import 'package:dartz/dartz.dart';

abstract class IMovimentoUseCases {
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento);
  Future<Either<Failure, Movimento>> getMovimento(int id);
  Future<Either<Failure, double>> getSaldo(int contaId, [int? mes]);
  Future<Either<Failure, List<Movimento>>> listMovimentos();
  Future<Either<Failure, List<Movimento>>> listMovimentosDaSemana();
  Future<Either<Failure, List<Movimento>>> listMovimentosPendentes();
  Future<Either<Failure, List<Movimento>>> listMovimentosEntrada(
      {DateTime? date});
  Future<Either<Failure, List<Movimento>>> listMovimentosSaida(
      {DateTime? date});
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(
    int page,
    int pageSize,
  );
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date);
  Future<Either<Failure, bool>> editMovimento(Movimento movimento);
  Future<Either<Failure, bool>> deleteMovimento(int id);

  Future<Either<Failure, List<Movimento>>> listPaginatedContaMovimentos(
    int currentIndex,
    int page,
    int pageSize,
  );
  Future<Either<Failure, List<Movimento>>> transferirMovimentos(
    List<Movimento> movimentos,
    int destinoId,
  );
  void addListener(Function fn);
  void removeListener(Function fn);

  Future<Either<Failure, List<int>>> getTotalMovimentos(int contaId);
}
