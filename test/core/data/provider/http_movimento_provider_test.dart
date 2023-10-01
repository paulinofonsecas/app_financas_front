import 'dart:convert';

import 'package:app_financas/core/data/provider/http_movimento_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  var dio = Dio();
  var dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;

  var movimentoProvider = HttpMovimentoProvider(dio);

  onGet(String path, int statusCode, dynamic response) {
    dioAdapter.onGet(
      path,
      (request) => request.reply(statusCode, response, headers: {
        'contentType': [Headers.jsonContentType],
      }),
    );
  }

  test('http movimento provider ...', () async {
    onGet(
        '/movimentos',
        200,
        json.encode(
            '''{
    "data": [
        {
            "id": 1,
            "valor": 821239,
            "data": "1991-08-28 00:00:00",
            "descricao": "Omnis officia voluptas qui.",
            "cartao_id": 1,
            "cartao_nome": "Mrs. Sandrine Dooley IV",
            "tipo_movimento_id": {
                "id": 2,
                "nome": null
            },
            "created_at": "2023-08-27T23:38:48.000000Z"
        },
        {
            "id": 3,
            "valor": 74695,
            "data": "2013-06-15 00:00:00",
            "descricao": "Est modi sed molestias unde eum assumenda sint.",
            "cartao_id": 2,
            "cartao_nome": "Kale Douglas",
            "tipo_movimento_id": {
                "id": 1,
                "nome": null
            },
            "created_at": "2023-08-27T23:38:48.000000Z"
        },
        {
            "id": 4,
            "valor": 828360,
            "data": "1994-09-20 00:00:00",
            "descricao": "Molestiae ad repudiandae ipsum non aliquam fugit.",
            "cartao_id": 8,
            "cartao_nome": "Ms. Aubrey Abbott",
            "tipo_movimento_id": {
                "id": 2,
                "nome": null
            },
            "created_at": "2023-08-27T23:38:48.000000Z"
        }]}'''));

    var result = await movimentoProvider.listMovimentos();

    expect(result, isA<Right>());
    expect(result.getOrElse(() => []).length, 1);
  });
}
