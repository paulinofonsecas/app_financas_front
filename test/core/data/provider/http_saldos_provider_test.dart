import 'package:app_financas/core/data/provider/http/http_saldos_provider.dart';
import 'package:app_financas/presentation/helders/http_helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var dio = makeDefaultDio();
  var saldoProvider = HttpSaldosProvider(dio);

  test('Deve retornar o saldo disponivel', () async {
    var result = await saldoProvider.getSaldoDisponivel();

    expect(result, isA<Right>());
    expect(result.getOrElse(() => 0), isA<double>());
    if (kDebugMode) {
      print(result.getOrElse(() => 0));
    }
  });
}
