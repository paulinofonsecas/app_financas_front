import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import 'package:app_financas/core/erros/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../interfaces/i_categoria_provider.dart';
import 'helpers/db_hive_box_names.dart';

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

      var lastId = _categoriasEntradaBox.values.length + 1;
      categoria = categoria.copyWith(id: lastId);
      var map = categoria.toMap();
      await _categoriasEntradaBox.put(lastId, map);
      return const Right(true);
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
      ];

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
      var categoriasPadrao = [
        Categoria(
          id: 1,
          name: 'Salário',
          icon: Icons.attach_money,
          color: Colors.green,
        ),
        Categoria(
          id: 2,
          name: 'Rendimento',
          icon: Icons.construction_sharp,
          color: Colors.orange,
        ),
        Categoria(
          id: 3,
          name: 'Outra',
          icon: Icons.construction_sharp,
          color: Colors.cyan,
        ),
      ];

      for (var categoria in categoriasPadrao) {
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
