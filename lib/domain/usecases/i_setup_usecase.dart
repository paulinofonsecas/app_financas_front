import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/sertup_configuration.dart';
import 'package:app_financas/domain/repositories/i_setup_repository.dart';

import 'package:dartz/dartz.dart';

abstract class ISetupUseCases {
  Future<Either<Failure, SetupConfiguration>> setup();
}

class SetupUseCases implements ISetupUseCases {
  final ISetupRepository _repository;

  SetupUseCases(this._repository);

  @override
  Future<Either<Failure, SetupConfiguration>> setup() {
    return _repository.setup();
  }
}
