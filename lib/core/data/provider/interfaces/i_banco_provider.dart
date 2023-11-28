import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IBancoProvider {
  Future<Either<Failure, List<Banco>>> listBancos();
}
