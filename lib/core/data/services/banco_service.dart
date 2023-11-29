import 'package:app_financas/core/data/provider/interfaces/i_banco_provider.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/domain/services/i_banco_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class BancoService implements IBancoService {
  final IBancoProvider provider;

  BancoService(this.provider);

  @override
  Future<Either<Failure, Banco>> getBanco(int id) {
    return provider.getBanco(id);
  }

  @override
  Future<Either<Failure, List<Banco>>> listBancos() {
    return provider.listBancos();
  }
}
