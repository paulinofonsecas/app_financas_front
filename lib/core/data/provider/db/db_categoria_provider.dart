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
    await initCategoriaEntradasDb();
    var result = _categoriasEntradaBox.toMap();

    if (result.isEmpty) {
      var categoriasPadrao = [
        'Salário',
        'Horas Extras',
        'Rendimento',
        'Devolução',
        'Outro',
      ];

      for (var cat in categoriasPadrao) {
        await saveEntradaCategoria(Categoria(id: -1, name: cat));
      }
      return listCategoriasEntradas();
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
      var categoriasPadrao = [
        'Pagamento',
        'Divida',
        'Emprestimo',
        'Outro',
      ];

      for (var cat in categoriasPadrao) {
        await saveSaidaCategoria(Categoria(id: -1, name: cat));
      }
      return listCategoriasSaidas();
    }

    return Right(
      result.values
          .map((e) => Categoria.fromMap(e.cast<String, dynamic>()))
          .toList(),
    );
  }
}
