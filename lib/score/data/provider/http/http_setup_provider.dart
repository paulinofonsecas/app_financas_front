import 'package:app_financas/score/data/provider/interfaces/i_setup_provider.dart';
import 'package:app_financas/score/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpSetupProvider implements ISetupProvider {
  final Dio dio;

  HttpSetupProvider(this.dio);

  @override
  Future<Either<Failure, SetupConfiguration>> setup() async {
    try {
      var result = await dio.get(
        '/setup',
      );
      var data = result.data;
      var setupConfig = SetupConfiguration.fromMap(data);
      return Right(setupConfig);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(HttpException('Erro ao buscar invocar setup \n ${e.error}'));
    }
  }
}
