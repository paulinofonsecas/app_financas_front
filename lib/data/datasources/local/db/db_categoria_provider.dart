import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/data/datasources/interfaces/i_categoria_provider.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'helpers/db_hive_box_names.dart';

var categoriasPadrao = [
  Categoria(
    id: 1,
    name: 'Casa',
    icon: Icons.attach_money,
    color: Colors.green,
  ),
  Categoria(
    id: 2,
    name: 'Educação',
    icon: Icons.book,
    color: Colors.orange,
  ),
  Categoria(
    id: 3,
    name: 'Lazer',
    icon: Icons.beach_access,
    color: Colors.cyan,
  ),
  Categoria(
    id: 4,
    name: 'Outros',
    icon: Icons.more_horiz,
    color: Colors.cyan,
  ),
  Categoria(
    id: 5,
    name: 'Alimentação',
    icon: Icons.fastfood,
    color: Colors.red,
  ),
  Categoria(
    id: 6,
    name: 'Transporte',
    icon: Icons.directions_car,
    color: Colors.blue,
  ),
  Categoria(
    id: 7,
    name: 'Saúde',
    icon: Icons.local_hospital,
    color: Colors.pink,
  ),
  Categoria(
    id: 8,
    name: 'Entretenimento',
    icon: Icons.movie,
    color: Colors.purple,
  ),
  Categoria(
    id: 9,
    name: 'Roupas',
    icon: Icons.shopping_bag,
    color: Colors.indigo,
  ),
  Categoria(
    id: 10,
    name: 'Viagem',
    icon: Icons.airplanemode_active,
    color: Colors.teal,
  ),
  Categoria(
    id: 11,
    name: 'Tecnologia',
    icon: Icons.devices,
    color: Colors.grey,
  ),
  Categoria(
    id: 12,
    name: 'Investimentos',
    icon: Icons.trending_up,
    color: Colors.greenAccent,
  ),
  Categoria(
    id: 13,
    name: 'Doações',
    icon: Icons.volunteer_activism,
    color: Colors.lightBlue,
  ),
  Categoria(
    id: 14,
    name: 'Assinaturas',
    icon: Icons.subscriptions,
    color: Colors.deepPurple,
  ),
  Categoria(
    id: 15,
    name: 'Cuidados Pessoais',
    icon: Icons.spa,
    color: Colors.pinkAccent,
  ),
  Categoria(
    id: 16,
    name: 'Pets',
    icon: Icons.pets,
    color: Colors.brown,
  ),
  Categoria(
    id: 17,
    name: 'Reparos',
    icon: Icons.build,
    color: Colors.orangeAccent,
  ),
  Categoria(
    id: 18,
    name: 'Comunicações',
    icon: Icons.phone,
    color: Colors.lime,
  ),
  Categoria(
    id: 19,
    name: 'Impostos',
    icon: Icons.receipt,
    color: Colors.redAccent,
  ),
  Categoria(
    id: 20,
    name: 'Presentes',
    icon: Icons.card_giftcard,
    color: Colors.amber,
  ),
];

final categoriasDeEntradaPadrao = [
  Categoria(
    id: 1,
    name: 'Salário',
    icon: Icons.account_balance_wallet,
    color: Colors.green,
  ),
  Categoria(
    id: 2,
    name: 'Freelance',
    icon: Icons.work,
    color: Colors.blue,
  ),
  Categoria(
    id: 3,
    name: 'Investimentos',
    icon: Icons.trending_up,
    color: Colors.purple,
  ),
  Categoria(
    id: 4,
    name: 'Presente',
    icon: Icons.card_giftcard,
    color: Colors.red,
  ),
  Categoria(
    id: 5,
    name: 'Reembolso',
    icon: Icons.money_off,
    color: Colors.orange,
  ),
  Categoria(
    id: 6,
    name: 'Venda',
    icon: Icons.shopping_cart,
    color: Colors.cyan,
  ),
  Categoria(
    id: 7,
    name: 'Dividendos',
    icon: Icons.pie_chart,
    color: Colors.indigo,
  ),
  Categoria(
    id: 8,
    name: 'Aluguel',
    icon: Icons.home_work,
    color: Colors.teal,
  ),
  Categoria(
    id: 9,
    name: 'Prêmios',
    icon: Icons.emoji_events,
    color: Colors.yellow,
  ),
  Categoria(
    id: 10,
    name: 'Herança',
    icon: Icons.account_balance,
    color: Colors.brown,
  ),
];

class DbCategoriaProvider implements ICategoriaProvider {
  late Box<Map<dynamic, dynamic>> _categoriasEntradaBox;
  late Box<Map<dynamic, dynamic>> _categoriasSaidaBox;

  Future<void> initCategoriaEntradasDb() async {
    _categoriasEntradaBox = await Hive.openBox(kCategoriasEntradaBox);
  }

  Future<void> initCategoriaSaidasDb() async {
    _categoriasSaidaBox = await Hive.openBox(kCategoriasSaidaBox);
  }

  @override
  Future<Either<Failure, bool>> saveEntradaCategoria(
    Categoria categoria,
  ) async {
    try {
      await initCategoriaEntradasDb();
      if (categoria.id > 0) {
        await _categoriasEntradaBox.put(categoria.id, categoria.toMap());
        return const Right(true);
      } else {
        var lastId = _categoriasEntradaBox.values.length + 1;
        categoria = categoria.copyWith(id: lastId);
        var map = categoria.toMap();
        await _categoriasEntradaBox.put(lastId, map);
        return const Right(true);
      }
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> saveSaidaCategoria(Categoria categoria) async {
    try {
      await initCategoriaSaidasDb();

      var lastId = _categoriasSaidaBox.values.length + 1;
      categoria = categoria.copyWith(id: lastId);
      var map = categoria.toMap();
      await _categoriasSaidaBox.put(lastId, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas() async {
    var result = await _getRawCategoriaEntrada();

    var finalResult = result.values
        .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
        .toList();
    finalResult.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Right(finalResult);
  }

  Future<Map<dynamic, Map<dynamic, dynamic>>> _getRawCategoriaSaida() async {
    await initCategoriaSaidasDb();
    var result = _categoriasSaidaBox.toMap();

    if (result.isEmpty) {
      for (var cat in categoriasPadrao) {
        await saveSaidaCategoria(cat);
      }

      return _getRawCategoriaSaida();
    }

    return result;
  }

  Future<Map<dynamic, Map<dynamic, dynamic>>> _getRawCategoriaEntrada() async {
    await initCategoriaEntradasDb();
    var result = _categoriasEntradaBox.toMap();

    if (result.isEmpty) {
      for (var categoria in categoriasDeEntradaPadrao) {
        await saveEntradaCategoria(categoria);
      }

      return _getRawCategoriaEntrada();
    }

    return result;
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas() async {
    var result = await _getRawCategoriaSaida();

    var finalResult = result.values
        .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
        .toList();

    finalResult.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Right(finalResult);
  }

  @override
  Future<Either<Failure, Categoria>> getEntradaCategoria(int id) async {
    var result = await listValidCategoriasEntradas();

    if (result is Right) {
      var categorias = result.getOrElse(() => []);

      var result0 = categorias.where((element) => element.id == id).firstOrNull;

      if (result0 != null) {
        return Right(result0);
      } else {
        return Left(
          NotFoundError('Nao foi possivel encontrar a categoria solicitada'),
        );
      }
    } else {
      return Left(
        Failure('Falha desconhecia ao lista as categorias de entrada'),
      );
    }
  }

  @override
  Future<Either<Failure, Categoria>> getSaidaCategoria(int id) async {
    var result = await listValidCategoriasSaidas();

    if (result is Right) {
      var categorias = result.getOrElse(() => []);

      var result0 = categorias.where((element) => element.id == id).firstOrNull;

      if (result0 != null) {
        return Right(result0);
      } else {
        return Left(
          NotFoundError('Nao foi possivel encontrar a categoria solicitada'),
        );
      }
    } else {
      return Left(
        Failure('Falha desconhecia ao lista as categorias de entrada'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategorias() async {
    await initCategoriaEntradasDb();
    await initCategoriaSaidasDb();

    var entradas = (await listCategoriasEntradas()).getOrElse(() => []);
    var saidas = (await listCategoriasSaidas()).getOrElse(() => []);

    return Right(entradas + saidas);
  }

  @override
  Future<Either<Failure, bool>> editEntradaCategoria(
      Categoria categoria) async {
    try {
      await initCategoriaEntradasDb();

      var map = categoria.toMap();
      await _categoriasEntradaBox.put(categoria.id, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> editSaidaCategoria(Categoria categoria) async {
    try {
      await initCategoriaSaidasDb();

      var map = categoria.toMap();
      await _categoriasSaidaBox.put(categoria.id, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> arquivarCategoriaEntrada(
      int categoriaId) async {
    await initCategoriaEntradasDb();

    try {
      var categoria0 = _categoriasEntradaBox.get(categoriaId);

      if (categoria0 == null) {
        return const Right(false);
      }

      var categoria = Categoria.fromMap(categoria0.cast<String, dynamic>());

      categoria = categoria.copyWith(isArchived: true);

      var map = categoria.toMap();
      await _categoriasEntradaBox.put(categoria.id, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> arquivarCategoriaSaida(int categoriaId) async {
    await initCategoriaSaidasDb();

    try {
      var categoria0 = _categoriasSaidaBox.get(categoriaId);

      if (categoria0 == null) {
        return const Right(false);
      }

      var categoria = Categoria.fromMap(categoria0.cast<String, dynamic>());

      categoria = categoria.copyWith(isArchived: true);

      var map = categoria.toMap();
      await _categoriasSaidaBox.put(categoria.id, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> desarquivarCategoriaEntrada(
      int categoriaId) async {
    await initCategoriaSaidasDb();

    try {
      var categoria0 = _categoriasEntradaBox.get(categoriaId);

      if (categoria0 == null) {
        return const Right(false);
      }

      var categoria = Categoria.fromMap(categoria0.cast<String, dynamic>());

      categoria = categoria.copyWith(isArchived: false);

      var map = categoria.toMap();
      await _categoriasEntradaBox.put(categoria.id, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> desarquivarCategoriaSaida(
      int categoriaId) async {
    await initCategoriaSaidasDb();

    try {
      var categoria0 = _categoriasSaidaBox.get(categoriaId);

      if (categoria0 == null) {
        return const Right(false);
      }

      var categoria = Categoria.fromMap(categoria0.cast<String, dynamic>());

      categoria = categoria.copyWith(isArchived: false);

      var map = categoria.toMap();
      await _categoriasSaidaBox.put(categoria.id, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, List<Categoria>>>
      listArchivedCategoriasEntradas() async {
    var result = await _getRawCategoriaEntrada();
    var finalResult = result.values
        .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
        .where((element) => element.isArchived)
        .toList();
    finalResult.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Right(finalResult);
  }

  @override
  Future<Either<Failure, List<Categoria>>>
      listArchivedCategoriasSaidas() async {
    var result = await _getRawCategoriaSaida();

    var finalResult = result.values
        .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
        .where((element) => element.isArchived)
        .toList();

    finalResult.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Right(finalResult);
  }

  @override
  Future<Either<Failure, List<Categoria>>> listValidCategoriasEntradas() async {
    var result = await _getRawCategoriaEntrada();

    var finalResult = result.values
        .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
        .where((element) => !element.isArchived)
        .toList();
    finalResult.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Right(finalResult);
  }

  @override
  Future<Either<Failure, List<Categoria>>> listValidCategoriasSaidas() async {
    var result = await _getRawCategoriaSaida();

    var finalResult = result.values
        .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
        .where((element) => !element.isArchived)
        .toList();
    finalResult.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Right(finalResult);
  }
}
