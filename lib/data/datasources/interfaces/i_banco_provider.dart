import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/banco.dart';

import 'package:dartz/dartz.dart';

abstract class IBancoProvider {
  Future<Either<Failure, List<Banco>>> listBancos();
  Future<Either<Failure, Banco>> getBanco(int id);
}
