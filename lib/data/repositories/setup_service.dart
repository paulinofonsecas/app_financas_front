import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/sertup_configuration.dart';
import 'package:app_financas/domain/repositories/i_setup_repository.dart';
import 'package:app_financas/data/datasources/interfaces/i_setup_provider.dart';

import 'package:dartz/dartz.dart';

class SetupRepository implements ISetupRepository {
  final ISetupProvider provider;

  SetupRepository(this.provider);

  @override
  Future<Either<Failure, SetupConfiguration>> setup() {
    return provider.setup();
  }
}
