import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/data/datasources/local/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/data/datasources/interfaces/i_movimento_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_planejamento_provider.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/entities/item_planejamento.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBPlanejamentoProvider implements IPlanejamentoProvider {
  late Box<Map<dynamic, dynamic>> _planejamentoBox;
  late IMovimentoProvider _movimentoProvider;
  late ICategoriaUseCases _categoriaService;

  DBPlanejamentoProvider(
      {required IMovimentoProvider movimentoProvider,
      required ICategoriaUseCases categoriaService})
      : super() {
    _movimentoProvider = movimentoProvider;
    _categoriaService = categoriaService;
  }

  Future<void> initDb() async {
    _planejamentoBox = await Hive.openBox(kPlanejamentoBox);
  }

  Future<void> closeDb() async {
    await _planejamentoBox.close();
  }

  Future<Either<Failure, List<Movimento>>> _alimentarMovimentos() async {
    // periodo: do inicial ao final do mes atual
    final result = await _movimentoProvider.listMovimentosSaida(
      date: DateTime.now(),
    );

    return result;
  }

  Future<Either<Failure, List<Categoria>>> _getCategorias() async {
    final result = await _categoriaService.listCategoriasSaidas();
    return result;
  }

  @override
  Future<Either<Failure, Planejamento>> createPlanejamento(
      Planejamento planejamento) async {
    if (planejamento.itens.isEmpty) {
      return Left(Failure('Planejamento sem itens'));
    }

    try {
      await initDb();

      if (_planejamentoBox.keys.contains(planejamento.id)) {
        return Left(Failure('Duplicação de id'));
      }

      await _planejamentoBox.put(planejamento.id, planejamento.toMap());

      return Right(planejamento);
    } catch (e) {
      await closeDb();
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlanejamento(
      String planejamentoId) async {
    try {
      await initDb();

      if (!_planejamentoBox.keys.contains(planejamentoId)) {
        return Left(Failure('Planejamento nao encontrado'));
      }

      await _planejamentoBox.delete(planejamentoId);

      return const Right(null);
    } catch (e) {
      return Future.value(Left(Failure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<Planejamento>>> getAllPlanejamentos(
      {DateTime? dataReferencia}) async {
    try {
      await initDb();

      // recupera o planejamento na box
      final planejamentoDataRaw = _planejamentoBox.values.toList();
      if (planejamentoDataRaw.isEmpty) {
        return const Right([]);
      }

      // recupera todos os movimentos para alimentar a lista de
      // ItemPlanejamento
      final movimentosResult = await _alimentarMovimentos();
      var movimentos = <Movimento>[];
      if (movimentosResult.isRight()) {
        movimentos.addAll(movimentosResult.getOrElse(() => []));
      } else {
        return Left(movimentosResult.swap().getOrElse(() => Failure('')));
      }

      final date = dataReferencia ?? DateTime.now();
      movimentos = movimentos
          .where(
            (mov) => mov.data.year == date.year && mov.data.month == date.month,
          )
          .toList();

      // pega todas as categorias
      final categoriasResult = await _getCategorias();
      if (categoriasResult.isLeft()) {
        return Left(categoriasResult
            .swap()
            .getOrElse(() => Failure('Erro ao recuperar categorias')));
      }
      final categorias = categoriasResult.getOrElse(() => []);

      final saida = <Planejamento>[];
      for (var planejamentoData in planejamentoDataRaw) {
        // alimenta a lista de ItemPlanejamento com os movimentos
        final itemPlanejamentoList = (planejamentoData['itens'] as List).map(
          (e) {
            final movimentosDoIten = movimentos
                .where((mov) =>
                    mov.categoria!.id == e['categoria'] ||
                    mov.subCategoria?.id == e['categoria'])
                .toList();

            final subCategorias = categorias
                .map(
                    (f) => f.subCategorias.map((g) => g.copyWith(icon: f.icon)))
                .reduce(
                  (value, element) => [...value, ...element],
                );
            final categoria = [...categorias, ...subCategorias]
                .where((c) => c.id == e['categoria'])
                .first;

            var item = ItemPlanejamento.fromMap(e);
            item = item.copyWith(
              movimentos: movimentosDoIten,
              categoria: categoria,
            );

            return item;
          },
        ).toList();

        // alimenta o planejamento com os itens
        saida.add(Planejamento.fromMap(planejamentoData).copyWith(
          itens: itemPlanejamentoList,
        ));
      }

      return Right(saida);
    } catch (e) {
      await closeDb();
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamento(
      String planejamentoId) async {
    try {
      final result = await getAllPlanejamentos();

      if (result.isRight()) {
        final planejamentoList = result.getOrElse(() => []);

        if (planejamentoList.isEmpty) {
          return Left(Failure('Planejamento nao encontrado'));
        }

        return Right(planejamentoList
            .firstWhere((planejamento) => planejamento.id == planejamentoId));
      } else {
        return Left(result
            .swap()
            .getOrElse(() => Failure('Erro ao buscar planejamento.')));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Planejamento>> updatePlanejamento(
      Planejamento planejamento) async {
    if (planejamento.itens.isEmpty) {
      return Left(Failure('Planejamento sem itens'));
    }

    try {
      await initDb();

      if (!_planejamentoBox.keys.contains(planejamento.id)) {
        return Left(Failure('Planejamento nao encontrado'));
      }

      await _planejamentoBox.put(planejamento.id, planejamento.toMap());

      return Right(planejamento);
    } catch (e) {
      await closeDb();
      return Left(Failure(e.toString()));
    }
  }
}
