import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

import 'package:app_financas/core/erros/failure.dart';

import 'package:dartz/dartz.dart';
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

      var map = categoria.toMap();
      var lastId = _categoriasEntradaBox.values.length + 1;
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

      var map = categoria.toMap();
      var lastId = _categoriasSaidaBox.values.length + 1;
      await _categoriasSaidaBox.put(lastId, map);
      return const Right(true);
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas() async {
    await initCategoriaEntradasDb();
    var result = _categoriasEntradaBox.toMap();

    if (result.isEmpty) {
      return const Right([]);
    }

    return Right(
      result.values
          .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas() async {
    await initCategoriaSaidasDb();
    var result = _categoriasSaidaBox.toMap();

    if (result.isEmpty) {
      return const Right([]);
    }

    return Right(
      result.values
          .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
          .toList(),
    );
  }
}
