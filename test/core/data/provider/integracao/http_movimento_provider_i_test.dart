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
}
