import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

import '../entitys/movimento.dart';

abstract class IMovimentoService {
  Future<Either<Failure, List<Movimento>>> listMovimentos();
}
