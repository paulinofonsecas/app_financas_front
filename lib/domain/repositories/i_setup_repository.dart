import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/sertup_configuration.dart';

import 'package:dartz/dartz.dart';

abstract class ISetupRepository {
  Future<Either<Failure, SetupConfiguration>> setup();
}
