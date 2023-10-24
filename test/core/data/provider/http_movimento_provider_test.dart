import 'package:app_financas/core/data/provider/http_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/http_helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var dio = makeDefaultDio();
  var httpProvider = HttpMovimentoProvider(dio);

  test('Deve retornar a lista de movimentos do usuario', () async {
    var result = await httpProvider.listMovimentos();

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<Movimento>>());
  });

  test('Deve retornar a lista de movimentos paginados do usuario', () async {
    var page = 1;
    var pageSize = 12;

    var result = await httpProvider.listPaginatedMovimentos(page, pageSize);
    var movimentos = result.getOrElse(() => []);

    expect(result, isA<Right>());
    expect(movimentos, isA<List<Movimento>>());
    expect(movimentos.length, pageSize);
  });

  test('Deve retornar um movimentos', () async {
    var result = await httpProvider.getMovimento(6);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => Movimento.fake()), isA<Movimento>());
  });

  test('Deve salvar um movimento e retornar o objeto salvo', () async {
    var movimento = Movimento.make(
      valor: 15000,
      data: DateTime.now(),
      descricao: 'Compra de auriculares',
      cartaoId: 1,
      tipoMovimentoId: 2,
      categoriaMovimentoId: 1,
      obsMovimento: 'Silva porto',
      confirmado: true,
    );
    var result = await httpProvider.saveMovimento(movimento);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => Movimento.fake()), isA<Movimento>());
    if (kDebugMode) {
      print(result.getOrElse(() => Movimento.fake()));
    }
  });

  test('Deve editar um movimento e retornar o objeto salvo', () async {
    var movimento = Movimento.fromMap({
      "id": 6,
      "valor": 16000,
      "data": "2023-10-17 10:33:00",
      "descricao": "Cafe Teste",
      "user_id": 1,
      "cartao_id": 2,
      "cartao_nome": "Familiar",
      "tipo_movimento_id": 2,
      "obs_movimento": null,
      "categoria_movimento_id": 1,
      "confirmado": 0,
      "created_at": "2023-10-12T09:34:51.000000Z",
      "updated_at": "2023-10-17T19:24:04.000000Z"
    });

    var result = await httpProvider.editMovimento(movimento);

    expect(result, isA<Right>());
    expect(result.getOrElse(() => false), isA<bool>());
    expect(result.getOrElse(() => false), true);
    if (kDebugMode) {
      print(result.getOrElse(() => false));
    }
  });
}
