import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IMovimentoProvider {
  Future<Either<Failure, List<Movimento>>> listMovimentos();
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(int page, int pageSize);
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date);
  Future<Either<Failure, Movimento>> getMovimento(int id);
  Future<Either<Failure, Movimento>> saveMovimento(Movimento movimento);
  Future<Either<Failure, bool>> editMovimento(Movimento movimento);
}
