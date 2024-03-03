import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

import '../entitys/movimento.dart';

abstract class IMovimentoService {
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento);
  Future<Either<Failure, Movimento>> getMovimento(int id);
  Future<Either<Failure, List<Movimento>>> listMovimentos();
  Future<Either<Failure, List<Movimento>>> listMovimentosPendentes();
  Future<Either<Failure, List<Movimento>>> listMovimentosEntrada({DateTime? date});
  Future<Either<Failure, List<Movimento>>> listMovimentosSaida({DateTime? date});
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
}
