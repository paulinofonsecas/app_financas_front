import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_planejamento_provider.dart';
import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/item_planejamento.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

class MovimentoProviderMock extends Mock implements IMovimentoProvider {
  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() async {
    final fakeMov = Movimento.fake().copyWith(categoria: Categoria.fake());
    return Right([fakeMov]);
  }
}

void main() {
  dependencyInitialize();

  var path = Directory.current.path;
  final movimentoProvider = MovimentoProviderMock();
  final planejamentoProvider = DBPlanejamentoProvider(
    movimentoProvider: movimentoProvider,
  );

  setUp(() {
    Hive.init('$path/test/hive_testing_path');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await Hive.deleteBoxFromDisk(kPlanejamentoBox);
    await Hive.close();
  });

  group('Criar planejamento', () {
    test('Deve criar um planejamento', () async {
      final result = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3000,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(result, isA<Right>());
    });
    test('Erro ao criar um planejamento sem itens', () async {
      final result = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3000,
          itens: [],
        ),
      );

      expect(result, isA<Left>());
    });
    test('Erro ao criar dois planejamentos com o mesmo id', () async {
      await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3000,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      final result = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3000,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(result, isA<Left>());
      expect(
        result
            .swap()
            .getOrElse(
              () => Failure('Erro'),
            )
            .message,
        'Duplicação de id',
      );
    });
  });

  group('Recuperar planejamento', () {
    test('Recupera um planejamento pelo id com sucess', () async {
      final createResult = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(createResult, isA<Right>());
      final newPlanejamentoId =
          createResult.getOrElse(() => Planejamento.fake()).id;

      final getResult =
          await planejamentoProvider.getPlanejamento(newPlanejamentoId);

      expect(getResult, isA<Right>());
      expect(getResult.getOrElse(() => Planejamento.fake()).plafound, 3500);
    });
    test('Erro ao recuperar um planejamento inexistente pelo id', () async {
      final getResult = await planejamentoProvider.getPlanejamento('FakeId');

      expect(getResult, isA<Left>());
    });
    test('Recupera todos os planejamentos', () async {
      await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );
      await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste1',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );
      await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste2',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      final getResult = await planejamentoProvider.getAllPlanejamentos();

      expect(getResult, isA<Right>());
      expect(getResult.getOrElse(() => []).length, 3);
    });
    test('Recupera uma lista de planejamentos fazia', () async {
      final getResult = await planejamentoProvider.getAllPlanejamentos();

      expect(getResult, isA<Right>());
      expect(getResult.getOrElse(() => []).length, 0);
    });
  });

  group('Deletar planejamento', () {
    test('Deleta um planejamento pelo id', () async {
      final createResult = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(createResult, isA<Right>());
      final newPlanejamentoId =
          createResult.getOrElse(() => Planejamento.fake()).id;

      final deleteResult = await planejamentoProvider.deletePlanejamento(
        newPlanejamentoId,
      );

      expect(deleteResult, isA<Right>());
    });
    test('Erro ao deletar um planejamento inexistente pelo id', () async {
      final deleteResult = await planejamentoProvider.deletePlanejamento(
        'FakeId',
      );

      expect(deleteResult, isA<Left>());
    });
  });

  group('Atualizar planejamento', () {
    test('Atualiza um planejamento pelo id', () async {
      final createResult = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(createResult, isA<Right>());
      final newPlanejamentoId =
          createResult.getOrElse(() => Planejamento.fake()).id;

      final updateResult = await planejamentoProvider.updatePlanejamento(
        Planejamento(
          id: newPlanejamentoId,
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(updateResult, isA<Right>());
    });
    test('Erro ao atualizar um planejamento inexistente pelo id', () async {
      final updateResult = await planejamentoProvider.updatePlanejamento(
        Planejamento(
          id: 'FakeId',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(updateResult, isA<Left>());
    });
    test('Erro ao atualizar um planejamento sem itens', () async {
      final createResult = await planejamentoProvider.createPlanejamento(
        Planejamento(
          id: 'Teste',
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [ItemPlanejamento.fake()],
        ),
      );

      expect(createResult, isA<Right>());
      final newPlanejamentoId =
          createResult.getOrElse(() => Planejamento.fake()).id;

      final updateResult = await planejamentoProvider.updatePlanejamento(
        Planejamento(
          id: newPlanejamentoId,
          dataReferencia: DateTime.now(),
          plafound: 3500,
          itens: [],
        ),
      );

      expect(updateResult, isA<Left>());
    });
  });
}
