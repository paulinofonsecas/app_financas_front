import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  late IMovimentoProvider dbMovimentosProvider;
  var path = Directory.current.path;

  setUp(() {
    Hive.init('$path/test/hive_testing_path');

    dbMovimentosProvider = DbMovimentoProvider();
  });

  test('deve retornar um movimento', () async {
    var movimento = _makeFakeMovimento();
    await dbMovimentosProvider.saveMovimento(movimento);

    var result = await dbMovimentosProvider.getMovimento(1);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => Movimento.fake()), isA<Movimento>());
    expect(result.getOrElse(() => Movimento.fake()).id, 1);
  });

  test('Deve salvar um movimento', () async {
    var movimento = Movimento.make(
      id: 1,
      valor: 15000,
      data: DateTime.now(),
      descricao: 'Compra de auriculares',
      cartaoId: 1,
      tipoMovimentoId: 2,
      categoriaMovimentoId: 1,
      obsMovimento: 'Silva porto',
      confirmado: true,
    );

    var result = await dbMovimentosProvider.saveMovimento(movimento);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => false), isA<bool>());
  });

  test('Deve retornar a lista de movimentos', () async {
    var movimento = _makeFakeMovimento();

    await dbMovimentosProvider.saveMovimento(movimento);
    var result = await dbMovimentosProvider.listMovimentos();

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<Movimento>>());
    expect(result.getOrElse(() => []).length, 1);
    expect(result.getOrElse(() => []).first.id, 1);
  });
}

Movimento _makeFakeMovimento() {
  var movimento = Movimento.make(
    id: 1,
    valor: 15000,
    data: DateTime.now(),
    descricao: 'Compra de auriculares',
    cartaoId: 1,
    tipoMovimentoId: 2,
    categoriaMovimentoId: 1,
    obsMovimento: 'Silva porto',
    confirmado: true,
  );
  return movimento;
}
