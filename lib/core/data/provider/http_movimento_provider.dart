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
        '/movimento',
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

  @override
  Future<Either<Failure, Movimento>> saveMovimento(Movimento movimento) async {
    try {
      var result = await dio.post(
        '/movimento',
        data: {
          'valor': movimento.valor,
          'descricao': movimento.descricao,
          'cartao_id': movimento.cartaoId,
          'tipo_movimento_id': movimento.tipoMovimentoId,
          'categoria_movimento_id': movimento.categoriaMovimentoId,
          'obs_movimento': movimento.obsMovimento,
          'data': movimento.data.toString(),
        },
      );
      if (result.statusCode == 201) {
        dynamic movimento0 = result.data['movimento'];
        movimento0 = Movimento.fromMap(movimento0);
        return Right(movimento0 as Movimento);
      } else {
        return Left(HttpException('Erro ao cadastrar movimento'));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(HttpException('Erro ao listar os movimentos \n ${e.error}'));
    }
  }
}
