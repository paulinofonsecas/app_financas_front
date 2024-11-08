import 'package:app_financas/score/domain/entitys/banco.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IBancoProvider {
  Future<Either<Failure, List<Banco>>> listBancos();
  Future<Either<Failure, Banco>> getBanco(int id);
}
