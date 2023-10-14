import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

import '../entitys/movimento.dart';

abstract class IMovimentoService {
  Future<Either<Failure, Movimento>> saveMovimento(Movimento movimento);
  Future<Either<Failure, List<Movimento>>> listMovimentos();
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date);
}
