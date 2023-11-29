import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_banco_provider.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late DbBancoProvider dbBancoProvider;

  var path = Directory.current.path;
  setUp(() {
    Hive.init('$path/test/hive_testing_path');
    dbBancoProvider = DbBancoProvider();
  });

  group('Banco test', () {
    test('Deve retornar a lista de bancos cadastrados', () async {
      var result = await dbBancoProvider.listBancos();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isA<List<Banco>>());
      expect(result.getOrElse(() => []).length, 7);
      expect(
        result.getOrElse(() => []).first.nome,
        'Banco Angolano de Investimos',
      );
    });

    test('Retorna um banco', () async {
      var result = await dbBancoProvider.getBanco(1);

      expect(result, isA<Right>());
      expect(result.getOrElse(() => Banco.fake()).id, greaterThanOrEqualTo(0));
      expect(result.getOrElse(() => Banco.fake()).nome, isNotEmpty);
    });

    test('Retorna um erro ao buscar um banco', () async {
      var result = await dbBancoProvider.getBanco(1000);

      expect(result, isA<Left>());
      expect(result.swap().getOrElse(() => Failure('')).message,
          'Banco inexistente');
    });
  });
}
