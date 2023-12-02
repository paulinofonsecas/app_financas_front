import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/data/services/movimento_service.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late IMovimentoService movimentosService;
  var path = Directory.current.path;

  setUp(() {
    Hive.init('$path/test/hive_testing_path');

    movimentosService = MovimentoService(
        provider: DbMovimentoProvider(
      CategoriaService(DbCategoriaProvider()),
    ));
  });

  tearDown(() {
    Hive.deleteFromDisk();
    Hive.close();
  });

  test('Deve retornar a lista de movimentos paginados do usuario', () async {
    var indexList = List.generate(25, (index) => index + 1);
    for (var id in indexList) {
      var movimento = _makeFakeMovimento(id);
      await movimentosService.saveMovimento(movimento);
    }

    var page = 2;
    var pageSize = 12;

    var result = await movimentosService.listPaginatedMovimentos(
      page,
      pageSize,
    );

    var movimentos = result.getOrElse(() => []);
    expect(result, isA<Right>());
    expect(movimentos, isA<List<Movimento>>());
    expect(movimentos.length, 1);
  });
}

Movimento _makeFakeMovimento([int id = 1]) {
  var movimento = Movimento.make(
    id: id,
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
