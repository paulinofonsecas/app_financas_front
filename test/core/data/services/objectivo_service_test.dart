import 'package:app_financas/core/data/provider/interfaces/i_objectivo_provider.dart';
import 'package:app_financas/core/data/services/objectivo_service.dart';
import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ObjectivoProviderMock extends Mock implements IObjectivoProvider {}

void main() {
  group('Create Objectivo', () {
    test('should create and return a Objectivo', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.createObjectivo(objectivo))
          .thenAnswer((_) async => Right(objectivo));

      final service = ObjectivoService(provider);

      final result = await service.createObjectivo(objectivo);

      expect(result.isRight(), true);

      final objectivoResult = result.fold((l) => null, (r) => r);

      expect(objectivoResult, objectivo);
    });

    test('should return a Failure when targetValue is 0', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.createObjectivo(objectivo))
          .thenAnswer((_) async => Left(
                ErroAoCriarObjectivo(
                    'Erro ao criar o objectivo, targetValue deve ser maior que 0'),
              ));

      final service = ObjectivoService(provider);

      final result = await service.createObjectivo(objectivo);

      expect(result.isLeft(), true);

      final failureResult =
          result.fold((l) => l, (r) => Failure('Erro desconhecido'));

      expect(failureResult, isA<ErroAoCriarObjectivo>());
      expect(failureResult.message,
          'Erro ao criar o objectivo, targetValue deve ser maior que 0');
    });
  });

  group('List Objectivos', () {
    test('should return a list of Objectivos', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.listObjectivos())
          .thenAnswer((_) async => Right([objectivo]));

      final service = ObjectivoService(provider);

      final result = await service.listObjectivos();

      expect(result.isRight(), true);

      final objectivoResult = result.getOrElse(() => <Objectivo>[]);

      expect(objectivoResult, isA<List<Objectivo>>());
      expect(objectivoResult.first, objectivo);
    });

    // list of Objectivos pausados
    test('should return a list of Objectivos pausados', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
        isPaused: true,
      );
      final objectivo2 = Objectivo.make(
        name: 'test2',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.listObjectivos())
          .thenAnswer((_) async => Right([objectivo, objectivo2]));

      final service = ObjectivoService(provider);

      final result = await service.listObjectivosPausados();

      expect(result.isRight(), true);

      final objectivoResult = result.getOrElse(() => <Objectivo>[]);

      expect(objectivoResult, isA<List<Objectivo>>());
      expect(objectivoResult.length, 1);
      expect(objectivoResult.first, objectivo);
    });

    // list of Objectivos finalizados
    test('should return a list of Objectivos finalizados', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );
      final objectivo2 = Objectivo.make(
        name: 'test2',
        description: 'test',
        targetValue: 20000,
        currentValue: 20000,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.listObjectivos())
          .thenAnswer((_) async => Right([objectivo, objectivo2]));

      final service = ObjectivoService(provider);

      final result = await service.listObjectivosFinalizados();

      expect(result.isRight(), true);

      final objectivoResult = result.getOrElse(() => <Objectivo>[]);

      expect(objectivoResult, isA<List<Objectivo>>());
      expect(objectivoResult.length, 1);
      expect(objectivoResult.first, objectivo2);
    });
  });

  group('Update Objectivo', () {
    test('should update a Objectivo', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.updateObjectivo(objectivo))
          .thenAnswer((_) async => Right(objectivo.copyWith(
                targetValue: 20000,
              )));

      final service = ObjectivoService(provider);

      final result = await service.updateObjectivo(objectivo);

      expect(result.isRight(), true);

      final objectivoResult = result.getOrElse(() => Objectivo.fake());

      expect(objectivoResult, objectivo.copyWith(targetValue: 20000));
    });

    test('Return a ObjectivoNaoEncontrado when not found', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.updateObjectivo(objectivo)).thenAnswer((_) async =>
          Left(ObjectivoNaoEncontrado('Objectivo nao encontrado')));

      final service = ObjectivoService(provider);

      final result = await service.updateObjectivo(objectivo);

      expect(result.isLeft(), true);
      final erro = result.swap().getOrElse(() => Failure('Nao encontrado'));

      expect(erro, isA<ObjectivoNaoEncontrado>());
      expect(erro.message, 'Objectivo nao encontrado');
    });
  });

  group('Delete Objectivo', () {
    test('should delete a Objectivo', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.deleteObjectivo(objectivo.id))
          .thenAnswer((_) async => const Right(null));

      final service = ObjectivoService(provider);

      final result = await service.deleteObjectivo(objectivo.id);

      expect(result.isRight(), true);
    });

    test('Return a ObjectivoNaoEncontrado when not found', () async {
      final provider = ObjectivoProviderMock();
      final objectivo = Objectivo.make(
        name: 'test',
        description: 'test',
        targetValue: 0,
        color: Colors.red,
        finalDate: DateTime.now().add(const Duration(days: 10)),
        icon: Icons.add,
      );

      when(() => provider.deleteObjectivo(objectivo.id)).thenAnswer((_) async =>
          Left(ObjectivoNaoEncontrado('Objectivo nao encontrado')));

      final service = ObjectivoService(provider);

      final result = await service.deleteObjectivo(objectivo.id);

      expect(result.isLeft(), true);
      final erro = result.swap().getOrElse(() => Failure('Nao encontrado'));

      expect(erro, isA<ObjectivoNaoEncontrado>());
      expect(erro.message, 'Objectivo nao encontrado');
    });
  });
}
