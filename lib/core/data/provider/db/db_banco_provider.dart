import 'package:app_financas/core/data/provider/interfaces/i_banco_provider.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'helpers/db_hive_box_names.dart';

class DbBancoProvider implements IBancoProvider {
  DbBancoProvider();

  late Box<Map<dynamic, dynamic>> _bancoBox;

  Future<void> initDb() async {
    _bancoBox = await Hive.openBox(kBancoBox);
  }

  @override
  Future<Either<Failure, List<Banco>>> listBancos() async {
    try {
      await initDb();
      var data = _bancoBox.values.toList();
      var result = data.map<Banco>(Banco.fromMap).toList();

      if (result.isEmpty) {
        await _populateDefaultBancos();
        return listBancos();
      }

      return Right(result);
    } on Exception {
      return Left(Failure('Erro ao buscar os bancos'));
    }
  }

  Future<void> _populateDefaultBancos() async {
    await initDb();

    // Bancos angolanos
    var bancos = [
      Banco(
        id: 1,
        nome: 'Banco Angolano de Investimos',
        acronimo: 'BAI',
        imgAsset: 'assets/imgs/bancos/BAI.png',
      ),
      Banco(
        id: 2,
        nome: 'Banco de Poupança e Crédito',
        acronimo: 'BPC',
        imgAsset: 'assets/imgs/bancos/BPC.png',
      ),
      Banco(
        id: 3,
        nome: 'Banco de Fomento de Angola',
        acronimo: 'BFA',
        imgAsset: 'assets/imgs/bancos/BFA.png',
      ),
      Banco(
        id: 4,
        nome: 'Banco Millennium Atlântico',
        acronimo: 'Atlântico',
        imgAsset: 'assets/imgs/bancos/ATLANTICO.png',
      ),
      Banco(
        id: 5,
        nome: 'Caixa Geral de Angola SA',
        acronimo: 'Caixa',
      ),
      Banco(
        id: 6,
        nome: 'Banco de Negócios Internacional',
        acronimo: 'BNI',
      ),
      Banco(
        id: 7,
        nome: 'Banco BIC Angola',
        acronimo: 'BIC',
        imgAsset: 'assets/imgs/bancos/BIC.png',
      ),
    ];

    for (var banco in bancos) {
      _bancoBox.put(banco.id, banco.toMap());
    }
  }

  @override
  Future<Either<Failure, Banco>> getBanco(int id) async {
    try {
      await initDb();

      var data = _bancoBox.get(id);

      if (data == null) return Left(Failure('Banco inexistente'));

      var banco = Banco.fromMap(data);
      return Right(banco);
    } catch (e) {
      return Left(Failure('Ocorreu um erro ao buscar o banco'));
    }
  }
}
