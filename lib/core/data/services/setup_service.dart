import 'package:app_financas/core/data/provider/interfaces/i_setup_provider.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_setup_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class SetupService implements ISetupService {
  final ISetupProvider provider;

  SetupService(this.provider);

  @override
  Future<Either<Failure, SetupConfiguration>> setup() {
    return provider.setup();
  }
}
