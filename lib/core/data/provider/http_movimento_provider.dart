import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpMovimentoProvider implements IMovimentoProvider {
  final Dio dio;

  HttpMovimentoProvider(this.dio);

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() async {
    try {
      var result = await dio.get(
        '/movimentos',
      );
      List<dynamic> movimentos = result.data['data']
          .map<Movimento>((e) => Movimento.fromMap(e))
          .toList();
      return Right(movimentos as List<Movimento>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(HttpException('Erro ao listar os movimentos \n ${e.error}'));
    }
  }
}
