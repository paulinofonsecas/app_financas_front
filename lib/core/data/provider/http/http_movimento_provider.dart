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
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento) async {
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
          'confirmado': movimento.confirmado,
          'data': movimento.data.toString(),
        },
      );
      if (result.statusCode == 201) {
        dynamic movimento0 = result.data['movimento'];
        movimento0 = Movimento.fromMap(movimento0);
        return const Right(true);
      } else if (result.statusCode == 400) {
        return Left(SaldoInsuficiente('Saldo insuficiente'));
      } else {
        return Left(
            HttpException('Erro ao cadastrar movimento \n ${result.data}'));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }

      if (e.response?.statusCode == 400) {
        return Left(SaldoInsuficiente('Saldo insuficiente'));
      }

      return Left(HttpException('Erro ao listar os movimentos \n ${e.error}',
          error: e.error));
    }
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(
      DateTime date) async {
    try {
      var result = await dio.get('/movimento', data: {
        'date': date.toString(),
      });
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
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) async {
    try {
      var result = await dio.put(
        '/movimento/${movimento.id}',
        queryParameters: {
          'valor': movimento.valor,
          'descricao': movimento.descricao,
          'cartao_id': movimento.cartaoId,
          'categoria_movimento_id': movimento.categoriaMovimentoId,
          'obs_movimento': movimento.obsMovimento,
          'confirmado': movimento.confirmado ? 1 : 0,
          'data': movimento.data.toString(),
        },
      );

      if (result.statusCode == 200) {
        return const Right(true);
      } else {
        if (kDebugMode) {
          print(result.data);
        }
        return const Right(false);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }

      if (e.response?.statusCode == 400) {
        return Left(SaldoInsuficiente('Saldo insuficiente'));
      }

      return Left(HttpException(
        'Erro ao editar o movimento \n ${e.response?.statusCode}',
        error: e.error,
      ));
    }
  }

  @override
  Future<Either<Failure, Movimento>> getMovimento(int id) async {
    try {
      var result = await dio.get(
        '/movimento/$id',
      );
      dynamic movimento0 = result.data;
      var movimento = Movimento.fromMap(movimento0);
      return Right(movimento);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(HttpException('Erro ao listar os movimentos \n ${e.error}'));
    }
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(
      int page, int pageSize) async {
    try {
      var result = await dio.get(
        '/paginated/movimento?page=$page&pageSize=$pageSize',
      );
      List<dynamic> movimentos = result.data['data']
          .map<Movimento>((e) => Movimento.fromMap(e))
          .toList();
      return Right(movimentos as List<Movimento>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(
          HttpException('Erro ao listar os movimentos paginados\n ${e.error}'));
    }
  }

  @override
  Future<Either<Failure, double>> getSaldo(int id, [int? mes]) {
    // TODO: implement getSaldo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteMovimento(int id) {
    // TODO: implement deleteMovimento
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedContaMovimentos(
      int currentIndex, int page, int pageSize) {
    // TODO: implement listPaginatedContaMovimentos
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosEntrada({DateTime? date}) {
    // TODO: implement listMovimentosEntrada
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosSaida({DateTime? date}) {
    // TODO: implement listMovimentosSaida
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<int>>> getTotalMovimentos(int contaId) {
    // TODO: implement getTotalMovimentos
    throw UnimplementedError();
  }
}
