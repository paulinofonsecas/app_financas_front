import 'dart:io';

import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_conta_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/tipo_conta.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() async {
  late IContaProvider dbConta;
  late IMovimentoProvider movimentoProvider;
  var path = Directory.current.path;

  setUp(() {
    Hive.init('$path/test/hive_testing_path');
    var categoriaProvider = DbCategoriaProvider();
    var categoriaService = CategoriaService(categoriaProvider);

    movimentoProvider = DbMovimentoProvider(categoriaService);
    dbConta = DbContaProvider(movimentoProvider);

    locator.registerSingleton(dbConta);
  });

  tearDown(() {
    Hive.deleteFromDisk();
    Hive.close();
  });

  test('Deve retornar o saldo de uma conta', () async {
    var newConta = _createConta();
    var result = (await dbConta.saveConta(newConta)).getOrElse(() => false);
    expect(result, true);

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
    var result0 = (await dbConta.saveConta(newConta)).getOrElse(() => false);
    expect(result0, true);

    var result = await dbConta.listContas();
    expect(result, isA<Right>());
    expect(result.getOrElse(() => []), isA<List<Conta>>());
    expect(result.getOrElse(() => []).length, 1);
  });
}

Conta _createConta([int id = 1]) {
  return Conta(
    id: id,
    nome: 'Conta fake',
    saldo: 0.0,
    saldoInicial: 0.0,
    descricao: 'Conta fake',
    tipoConta: TipoConta.tipoContas.first,
    color: Colors.blue,
    iconAsset: null,
    showInSoma: null,
    isArchived: null,
  );
}
