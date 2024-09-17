import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_banco_provider.dart';
import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_conta_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_banco_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/tipo_conta.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() async {
  late IContaProvider dbConta;
  late IMovimentoProvider movimentoProvider;
  late IBancoProvider dbProvider;
  var path = Directory.current.path;

  setUp(() {
    Hive.init('$path/test/hive_testing_path');
    var categoriaProvider = DbCategoriaProvider();
    var categoriaService = CategoriaService(categoriaProvider);

    dbProvider = DbBancoProvider();
    movimentoProvider = DbMovimentoProvider(categoriaService);
    dbConta = DbContaProvider(
      movimentoProvider,
    );

    getIt.registerSingleton(dbConta);
  });

  tearDown(() async {
    await getIt.reset(dispose: true);
    await Hive.deleteFromDisk();
    await Hive.deleteBoxFromDisk(kContasBox);
    await Hive.close();
  });

  group('Conta', () {
    test('Deve retornar o saldo de uma conta', () async {
      var newConta = _createConta();
      var result = (await dbConta.saveConta(newConta)).getOrElse(() => -1);
      expect(result, isA<int>());

      await movimentoProvider.saveMovimento(Movimento.make(
        id: 1,
        valor: 15000,
        data: DateTime.now(),
        descricao: 'Compra de auriculares',
        contaId: newConta.id,
        tipoMovimentoId: 2,
        categoriaMovimentoId: 1,
        obsMovimento: 'Silva porto',
        confirmado: true,
      ));

      var conta = await dbConta.getConta(newConta.id);

      expect(conta, isA<Right>());
      expect(conta.getOrElse(() => Conta.fake()).saldo, 15000);
    });
    test('deve retornar a lista de contas', () async {
      var newConta = _createConta();
      var result0 = (await dbConta.saveConta(newConta)).getOrElse(() => -1);
      expect(result0, isA<int>());

      var result = await dbConta.listContas();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isA<List<Conta>>());
      expect(result.getOrElse(() => []).length, 1);
      expect(result.getOrElse(() => []).first.banco.nome, isNot('Conta fake'));
    });

    test('deve remover uma conta do banco', () async {
      var newConta = _createConta();
      var result0 = (await dbConta.saveConta(newConta)).getOrElse(() => -1);
      expect(result0, isA<int>());

      var result = await dbConta.listContas();

      expect(result, isA<Right>());
      expect(result.getOrElse(() => []), isA<List<Conta>>());
      expect(result.getOrElse(() => []).length, 1);
      expect(result.getOrElse(() => []).first.banco.nome, isNot('Conta fake'));

      await dbConta.removeConta(result.getOrElse(() => []).first.id);

      var result2 = await dbConta.listContas();
      expect(result2, isA<Right>());
      expect(result2.getOrElse(() => []).length, 3);
    });

    group('Balanco mensal', () {
      test('deve calcular o balanco mensal', () async {
        var movimento1 = Movimento.make(
          id: 1,
          valor: 100,
          data: DateTime.now(),
          contaId: 1,
          tipoMovimentoId: 1,
          categoriaMovimentoId: 1,
          obsMovimento: 'Silva porto',
          descricao: 'Teste 1',
          confirmado: true,
        );
        var moviemnto2 = Movimento.make(
          id: 2,
          valor: 10000,
          data: DateTime.now(),
          contaId: 1,
          tipoMovimentoId: 1,
          categoriaMovimentoId: 1,
          obsMovimento: 'Silva porto',
          descricao: 'Teste 2',
          confirmado: false,
        );

        await movimentoProvider.saveMovimento(movimento1);
        await movimentoProvider.saveMovimento(moviemnto2);

        var mesIndex = 11;
        var result = await dbConta.calcularBalancoMensal(mesIndex);

        expect(result, isA<Right>());
        expect(
          result.getOrElse(() => BalancoMensal.fake()),
          isA<BalancoMensal>(),
        );
        expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 100);
        expect(
            result.getOrElse(() => BalancoMensal.fake()).saldoPrevisto, 10100);
      });
      test('deve calcular o balanco mensal 2', () async {
        var movimento1 = Movimento.make(
          id: 1,
          valor: 100,
          data: DateTime.now(),
          contaId: 1,
          tipoMovimentoId: 1,
          categoriaMovimentoId: 1,
          obsMovimento: 'Silva porto',
          descricao: 'Teste 1',
          confirmado: true,
        );
        var moviemnto2 = Movimento.make(
          id: 2,
          valor: 10000,
          data: DateTime(2023, 10),
          contaId: 1,
          tipoMovimentoId: 1,
          categoriaMovimentoId: 1,
          obsMovimento: 'Silva porto',
          descricao: 'Teste 2',
          confirmado: false,
        );

        await movimentoProvider.saveMovimento(movimento1);
        await movimentoProvider.saveMovimento(moviemnto2);

        var mesIndex = 10;
        var result = await dbConta.calcularBalancoMensal(mesIndex);

        expect(result, isA<Right>());
        expect(
          result.getOrElse(() => BalancoMensal.fake()),
          isA<BalancoMensal>(),
        );
        expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 0);
        expect(
            result.getOrElse(() => BalancoMensal.fake()).saldoPrevisto, 10000);
      });
      test('Retorna 0 caso nao haja nenhum moviento', () async {
        var mesIndex = 10;
        var result = await dbConta.calcularBalancoMensal(mesIndex);

        expect(result, isA<Right>());
        expect(
          result.getOrElse(() => BalancoMensal.fake()),
          isA<BalancoMensal>(),
        );
        expect(result.getOrElse(() => BalancoMensal.fake()).saldo, 0);
        expect(result.getOrElse(() => BalancoMensal.fake()).saldoPrevisto, 0);
      });
      test('Retorna erro ao passar um mes invalido', () async {
        var mesIndex = 102;
        var result = await dbConta.calcularBalancoMensal(mesIndex);

        expect(result, isA<Left>());
        var erro = result.swap().getOrElse(() => Failure('Teste'));
        expect(
          erro,
          isA<Failure>(),
        );
        expect(erro.message, 'Mês inválido');
      });
    });
  });
}

Conta _createConta([int id = 1]) {
  return Conta(
    id: id,
    nome: 'Conta fake',
    saldo: 0.0,
    saldoInicial: 0.0,
    totalDespesas: 0,
    totalReceitas: 0,
    descricao: 'Conta fake',
    tipoConta: TipoConta.tipoContas.first,
    banco: Banco.fake(),
    color: Colors.blue,
    iconAsset: null,
    showInSoma: null,
    isArchived: null,
  );
}
