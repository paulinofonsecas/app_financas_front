import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IBancoService {
  Future<Either<Failure, List<Banco>>> listBancos();
  Future<Either<Failure, Banco>> getBanco(int id);
}