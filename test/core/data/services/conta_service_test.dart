import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/services/conta_service.dart';
import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_banco_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovimentoService extends Mock implements IMovimentoService {}

class MockBancoService extends Mock implements IBancoService {}

class MockContaProvider extends Mock implements IContaProvider {}

void main() {
  late ContaService service;
  late MockContaProvider provider;
  late MockBancoService bancoService;
  late MockMovimentoService movimentosService;

  setUp(() {
    provider = MockContaProvider();
    movimentosService = MockMovimentoService();
    bancoService = MockBancoService();

    registerFallbackValue(Conta.fake());
    service = ContaService(
      provider,
      movimentosService,
      bancoService,
    );
  });

  // group listar contas e movimentos

  group('listContas', () {
    test('error when listing contas returns Failure', () async {
      when(() => provider.listContas())
          .thenAnswer((_) async => Left(Failure('Erro ao listar as contas')));

      final result = await service.listContas();

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure('')).message,
          'Erro ao listar as contas');
    });

    test('successful listing of accounts', () async {
      when(() => movimentosService.getTotalMovimentos(any())).thenAnswer(
        (_) async => const Right([0, 0]),
      );

      when(() => movimentosService.getSaldo(any())).thenAnswer(
        (_) async => const Right(0),
      );

      when(() => bancoService.getBanco(any())).thenAnswer(
        (_) async => Right(Banco.fake()),
      );

      when(() => provider.listContas()).thenAnswer(
        (_) async => Right(
          [
            Conta.fake(id: 1, saldoicial: 100.0),
            Conta.fake(id: 2),
          ],
        ),
      );

      final result = await service.listContas();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => []).length, 2);
      expect(result.getOrElse(() => []).first.saldoInicial, 100.0);
    });

    // erro ao listar conta quando não tem banco
    test('error when listing account without bank returns Failure', () async {
      when(() => movimentosService.getTotalMovimentos(any())).thenAnswer(
        (_) async => const Right([0, 0]),
      );

      when(() => movimentosService.getSaldo(any())).thenAnswer(
        (_) async => const Right(0),
      );

      when(() => bancoService.getBanco(any())).thenAnswer(
        (_) async => Left(Failure('')),
      );

      when(() => provider.listContas()).thenAnswer(
        (_) async => Right(
          [
            Conta.fake(id: 1, saldoicial: 100.0),
            Conta.fake(id: 2),
          ],
        ),
      );

      final result = await service.listContas();

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure('')).message,
          'Erro ao buscar o banco');
    });

    // erro ao contar contas
    test('error when counting accounts returns Failure', () async {
      const errorMessage = 'Ocorreu um erro ao contar as contas.';

      when(() => provider.listContas())
          .thenAnswer((_) async => Left(Failure(errorMessage)));

      final result = await service.listContas();

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure('')).message, errorMessage);
    });
  });

  group('calcularBalancoMensal', () {
    test('invalid month index returns Failure', () async {
      final result = await service.calcularBalancoMensal(0);

      expect(result.isLeft(), true);
      expect(
          result.swap().getOrElse(() => Failure('')).message, 'Mês inválido');
    });

    test('error when listing movimentos returns Failure', () async {
      when(() => movimentosService.listMovimentos())
          .thenAnswer((_) async => Left(Failure('')));

      final result = await service.calcularBalancoMensal(2);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure('')).message,
          'Erro ao listar os movimentos no processamento do balanço mensal');
    });

    test('successful calculation of monthly balance', () async {
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
      when(() => movimentosService.listMovimentos()).thenAnswer(
        (_) async => const Right([]),
      );

      final result = await service.calcularBalancoMensal(DateTime.now().month);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 0);
    });

    test('calculation of monthly balance with movimentos in different months',
        () async {
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
