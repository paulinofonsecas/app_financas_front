import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  late IMovimentoProvider dbMovimentosProvider;
  var path = Directory.current.path;

  setUp(() {
    Hive.init('$path/test/hive_testing_path');
    dbMovimentosProvider =
        DbMovimentoProvider(CategoriaService(DbCategoriaProvider()));
  });

  tearDown(() {
    Hive.deleteFromDisk();
    Hive.close();
  });

  test('deve retornar um movimento', () async {
    var movimento = _makeFakeMovimento();
    await dbMovimentosProvider.saveMovimento(movimento);

    var result = await dbMovimentosProvider.getMovimento(1);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => Movimento.fake()), isA<Movimento>());
    expect(result.getOrElse(() => Movimento.fake()).id, 1);
  });

  test('Deve retornar um erro ao buscar um movimento', () async {
    var result = await dbMovimentosProvider.getMovimento(1);

    expect(result, isA<Left>());
  });

  test('Deve salvar um movimento', () async {
    var movimento = Movimento.make(
      id: 1,
      valor: 15000,
      data: DateTime.now(),
      descricao: 'Compra de auriculares',
      contaId: 1,
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
    for (var i in [1, 2, 3]) {
      var movimento = _makeFakeMovimento();
      movimento = movimento.copyWith(id: i);
      await dbMovimentosProvider.saveMovimento(movimento);
    }

    var result = await dbMovimentosProvider.listMovimentos();

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<Movimento>>());
    expect(result.getOrElse(() => []).length, 3);
    expect(result.getOrElse(() => []).first.id, 1);
  });

  test('Deve editar um movimento', () async {
    var movimento = _makeFakeMovimento();
    movimento = movimento.copyWith(id: 2);
    await dbMovimentosProvider.saveMovimento(movimento);

    var result = (await dbMovimentosProvider.getMovimento(1))
        .getOrElse(() => Movimento.fake());

    result = result.copyWith(
      valor: 30000,
      descricao: 'Compra de computador',
      cartaoId: 2,
      tipoMovimentoId: 1,
      categoriaMovimentoId: 2,
      obsMovimento: 'piloto',
      confirmado: false,
    );

    await dbMovimentosProvider.editMovimento(result);
    var result2 = (await dbMovimentosProvider.getMovimento(1))
        .getOrElse(() => Movimento.fake());

    expect(result2, isA<Movimento>());
    expect(result2.valor, 30000);
    expect(result2.obsMovimento, 'piloto');
    expect(result2.confirmado, false);
    expect(result2.categoriaMovimentoId, 2);
    expect(result2.cartaoId, 2);
    expect(result2.descricao, 'Compra de computador');
    expect(result2.tipoMovimentoId, 1);
  });

  group('Quatidade de transacoes', () {
    test('Deve retornar a zero quantidade de despesas e receitas por conta', () async {
    var result = await dbMovimentosProvider.getTotalMovimentos(1);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<int>>());
    expect(result.getOrElse(() => []).length, 2);
    expect(result.getOrElse(() => []).first, 0);
    expect(result.getOrElse(() => []).last, 0);
  });

  test('Deve retornar a quantidade de despesas e receitas por conta', () async {
    var movimento = _makeFakeMovimento();

    await dbMovimentosProvider.saveMovimento(movimento);
    await dbMovimentosProvider.saveMovimento(movimento);

    var result = await dbMovimentosProvider.getTotalMovimentos(1);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<int>>());
    expect(result.getOrElse(() => []).length, 2);
    expect(result.getOrElse(() => []).first, 2);
    expect(result.getOrElse(() => []).last, 0);
  });
  });
}

Movimento _makeFakeMovimento() {
  var movimento = Movimento.make(
    id: 1,
    valor: 15000,
    data: DateTime.now(),
    descricao: 'Compra de auriculares',
    contaId: 1,
    tipoMovimentoId: 2,
    categoriaMovimentoId: 1,
    obsMovimento: 'Silva porto',
    confirmado: true,
  );
  return movimento;
}
