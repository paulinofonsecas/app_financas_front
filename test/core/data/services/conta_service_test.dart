import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/services/conta_service.dart';
import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovimentoService extends Mock implements IMovimentoService {}

class MockContaProvider extends Mock implements IContaProvider {}

void main() {
  group('calcularBalancoMensal', () {
    test('invalid month index returns Failure', () async {
      final service = ContaService(
        MockContaProvider(),
        MockMovimentoService(),
      );

      final result = await service.calcularBalancoMensal(0);

      expect(result.isLeft(), true);
      expect(
          result.swap().getOrElse(() => Failure('')).message, 'Mês inválido');
    });

    test('error when listing movimentos returns Failure', () async {
      final movimentosService = MockMovimentoService();

      final service = ContaService(
        MockContaProvider(),
        movimentosService,
      );

      when(() => movimentosService.listMovimentos())
          .thenAnswer((_) async => Left(Failure('')));

      final result = await service.calcularBalancoMensal(2);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure('')).message,
          'Erro ao listar os movimentos no processamento do balanço mensal');
    });

    test('successful calculation of monthly balance', () async {
      final movimentosService = MockMovimentoService();

      final service = ContaService(
        MockContaProvider(),
        movimentosService,
      );

      when(() => movimentosService.listMovimentos()).thenAnswer(
        (_) async => Right(
          [
            Movimento.fake(
              valor: 2000,
              confirmado: true,
              tipoMovimentoId: 1,
            ),
            Movimento.fake(
              valor: 500,
              confirmado: true,
              tipoMovimentoId: -1,
            ),
          ],
        ),
      );

      final result = await service.calcularBalancoMensal(DateTime.now().month);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 1500);
    });

    test('calculation of monthly balance with no movimentos', () async {
      final movimentosService = MockMovimentoService();

      final service = ContaService(
        MockContaProvider(),
        movimentosService,
      );

      when(() => movimentosService.listMovimentos()).thenAnswer(
        (_) async => const Right([]),
      );

      final result = await service.calcularBalancoMensal(DateTime.now().month);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 0);
    });

    test('calculation of monthly balance with movimentos in different months',
        () async {
      final movimentosService = MockMovimentoService();

      final service = ContaService(
        MockContaProvider(),
        movimentosService,
      );

      when(() => movimentosService.listMovimentos()).thenAnswer(
        (_) async => Right(
          [
            Movimento.fake(
              valor: 2000,
              confirmado: true,
              tipoMovimentoId: 1,
            ),
            Movimento.fake(
              valor: 500,
              confirmado: true,
              tipoMovimentoId: -1,
              data: DateTime.now().add(const Duration(days: 35)),
            ),
          ],
        ),
      );

      final result = await service.calcularBalancoMensal(DateTime.now().month);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 2000);
    });
  });

  group('saveConta', () {
    late ContaService service;
    late MockContaProvider provider;
    late MockMovimentoService movimentoService;

    setUp(() {
      provider = MockContaProvider();
      movimentoService = MockMovimentoService();

      registerFallbackValue(Conta.fake());
      service = ContaService(
        provider,
        movimentoService,
      );
    });

    test('successful save operation', () async {
      when(() => provider.saveConta(any()))
          .thenAnswer((_) async => const Right(1));

      final result = await service.saveConta(Conta.fake());

      expect(result.isRight(), true);
      expect(result.getOrElse(() => 0), 1);
    });

    test('failed save operation due to provider error', () async {
      when(() => provider.saveConta(any())).thenAnswer(
        (_) async => Left(
          Failure('Erro ao salvar a conta no banco local ou remoto.'),
        ),
      );

      final result = await service.saveConta(Conta.fake());

      expect(result.isLeft(), true);
      expect(
        result.swap().getOrElse(() => Failure('')).message,
        'Erro ao salvar a conta no banco local ou remoto.',
      );
    });
  });
}
