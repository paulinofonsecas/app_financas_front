import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/banco.dart';
import 'package:app_financas/domain/repositories/i_banco_repository.dart';
import 'package:app_financas/data/datasources/interfaces/i_banco_provider.dart';

import 'package:dartz/dartz.dart';

class BancoRepository implements IBancoRepository {
  final IBancoProvider provider;

  BancoRepository(this.provider);

  @override
  Future<Either<Failure, Banco>> getBanco(int id) {
    return provider.getBanco(id);
  }

  @override
  Future<Either<Failure, List<Banco>>> listBancos() {
    return provider.listBancos();
  }
}
