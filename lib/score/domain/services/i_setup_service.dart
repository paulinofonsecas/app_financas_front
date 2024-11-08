import 'package:app_financas/score/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ISetupService {
  Future<Either<Failure, SetupConfiguration>> setup();
}
