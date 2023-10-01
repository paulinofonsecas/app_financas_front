import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IMovimentoProvider {
  Future<Either<Failure, List<Movimento>>> listMovimentos();
}
