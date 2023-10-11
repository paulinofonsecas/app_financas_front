import 'package:app_financas/core/data/provider/http_setup_provider.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/helders/http_helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var dio = makeDefaultDio();
  var httpProvider = HttpSetupProvider(dio);

  test('Deve retornar a lista de movimentos do usuario', () async {
    var result = await httpProvider.setup();

    expect(result, isA<Right>());
    var setup = result.getOrElse(() => SetupConfiguration.zero());
    expect(setup.categorias, isNotEmpty);
    expect(setup.cartoes, isNotEmpty);
  });
}
