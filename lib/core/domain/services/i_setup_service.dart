import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ISetupService {
  Future<Either<Failure, SetupConfiguration>> setup();
}
