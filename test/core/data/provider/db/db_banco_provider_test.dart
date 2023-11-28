import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_banco_provider.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
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

  testWidgets('Deve retornar a lista de bancos cadastrados', (tester) async {
    var result = await dbBancoProvider.listBancos();

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<Banco>>());
    expect(result.getOrElse(() => []).first.nome, 'Banco Angolano de Investimos');
  });
}
