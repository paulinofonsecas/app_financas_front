import 'package:app_financas/core/data/provider/interfaces/i_planejamento_provider.dart';
import 'package:app_financas/core/data/services/planejamento_service.dart';
import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PlanejamentoProviderMock extends Mock implements IPlanejamentoProvider {}

void main() {
  var planejamentoProvider = PlanejamentoProviderMock();
  var planejamentoService = PlanejamentoService(provider: planejamentoProvider);

  group('Obter planejamentos', () {
    test('Deve retornar o planejamento do mes atual', () async {
      when(() => planejamentoProvider.getAllPlanejamentos()).thenAnswer(
        (_) async => Right([Planejamento.fake()]),
      );

      final result = await planejamentoService.getPlanejamentoAtual();

      expect(
        result
            .getOrElse(
              () => Planejamento.fake(
                dataReferencia: DateTime(1999, 1, 1),
              ),
            )
            .dataReferencia
            .month,
        Planejamento.fake(
          dataReferencia: DateTime.now(),
        ).dataReferencia.month,
      );
    });

    test('Erro quanto nao existe um planejamento no periodo', () async {
      when(() => planejamentoProvider.getAllPlanejamentos()).thenAnswer(
        (_) async => const Right([]),
      );

      final result = await planejamentoService.getPlanejamentoAtual();

      expect(result.isLeft(), true);
    });

    test('Deve retornar o planejamento da data informada', () async {
      when(() => planejamentoProvider.getAllPlanejamentos()).thenAnswer(
        (_) async =>
            Right([Planejamento.fake(dataReferencia: DateTime(2022, 1, 1))]),
      );

      final result = await planejamentoService.getPlanejamentoOn(
        DateTime(2022, 1, 1),
      );

      expect(result.isRight(), true);
      expect(
        result
            .getOrElse(
              () => Planejamento.fake(),
            )
            .dataReferencia
            .month,
        1,
      );
    });

    test('Obter a lista de planejamentos', () async {
      when(() => planejamentoProvider.getAllPlanejamentos()).thenAnswer(
        (_) async => Right([
          Planejamento.fake(dataReferencia: DateTime(2022, 1, 1)),
          Planejamento.fake(dataReferencia: DateTime(2022, 2, 1)),
        ]),
      );

      final result = await planejamentoService.listPlanejamentos();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).length, 2);
    });
  });
}
