import 'package:app_financas/core/data/provider/interfaces/i_saldos_provider.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpSaldosProvider implements ISaldosProvider {
  final Dio dio;
  HttpSaldosProvider(this.dio);

  @override
  Future<Either<Failure, double>> getEntradas() async {
    try {
      var result = await dio.get(
        '/entradas_no_mes',
      );
      double saldoDisponivel = double.parse(result.data as String);
      return Right(saldoDisponivel);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(
          HttpException('Erro ao buscar o total de entradas no mes \n ${e.error}'));
    }
  }

  @override
  Future<Either<Failure, double>> getSaidas() async {
    try {
      var result = await dio.get(
        '/saidas_no_mes',
      );
      double saldoDisponivel = double.parse(result.data as String);
      return Right(saldoDisponivel);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(
          HttpException('Erro ao buscar o total de saidas no mes \n ${e.error}'));
    }
  }

  @override
  Future<Either<Failure, double>> getSaldoDisponivel() async {
    try {
      var result = await dio.get(
        '/saldo_disponivel',
      );
      double saldoDisponivel = double.parse(result.data as String);
      return Right(saldoDisponivel);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.error);
      }
      return Left(
          HttpException('Erro ao buscar o saldo disponivel \n ${e.error}'));
    }
  }
}
