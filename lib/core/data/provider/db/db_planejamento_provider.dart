import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_planejamento_provider.dart';
import 'package:app_financas/core/domain/entitys/item_planejamento.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBPlanejamentoProvider implements IPlanejamentoProvider {
  late Box<Map<dynamic, dynamic>> _planejamentoBox;
  late IMovimentoProvider _movimentoProvider;

  DBPlanejamentoProvider({required IMovimentoProvider movimentoProvider})
      : super() {
    _movimentoProvider = movimentoProvider;
  }

  Future<void> initDb() async {
    _planejamentoBox = await Hive.openBox(kPlanejamentoBox);
  }

  Future<void> closeDb() async {
    await _planejamentoBox.close();
  }

  Future<Either<Failure, List<Movimento>>> _alimentarMovimentos() async {
    final result = await _movimentoProvider.listMovimentos();

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
  Future<Either<Failure, List<Planejamento>>> getAllPlanejamentos() async {
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
      final movimentos = <Movimento>[];
      if (movimentosResult.isRight()) {
        movimentos.addAll(movimentosResult.getOrElse(() => []));
      } else {
        return Left(movimentosResult.swap().getOrElse(() => Failure('')));
      }

      final saida = <Planejamento>[];
      for (var planejamentoData in planejamentoDataRaw) {
        // alimenta a lista de ItemPlanejamento com os movimentos
        final itemPlanejamentoList =
            (planejamentoData['itens'] as List).map((e) {
          final movimentosDoIten = movimentos
              .where((mov) => mov.categoria!.id == e['categoria'])
              .toList();

          return ItemPlanejamento.fromMap(e)
            ..copyWith(
              movimentos: movimentosDoIten,
              categoria: movimentosDoIten.first.categoria!,
            );
        }).toList();

        // alimenta o planejamento com os itens
        saida.add(Planejamento.fromMap(planejamentoData as Map<String, dynamic>)
          ..copyWith(
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
      await initDb();

      if (!_planejamentoBox.keys.contains(planejamentoId)) {
        return Left(Failure('Planejamento nao encontrado'));
      }

      // recupera o planejamento na box
      final planejamentoDataRaw = _planejamentoBox.get(planejamentoId);
      if (planejamentoDataRaw == null) {
        return Left(Failure('Planejamento null'));
      }

      // recupera todos os movimentos para alimentar a lista de
      // ItemPlanejamento
      final movimentosResult = await _alimentarMovimentos();
      final movimentos = <Movimento>[];
      if (movimentosResult.isRight()) {
        movimentos.addAll(movimentosResult.getOrElse(() => []));
      } else {
        return Left(movimentosResult.swap().getOrElse(() => Failure('')));
      }

      // alimenta a lista de ItemPlanejamento com os movimentos
      final itemPlanejamentoList =
          (planejamentoDataRaw['itens'] as List).map((e) {
        final movimentosDoIten = movimentos
            .where((mov) => mov.categoria!.id == e['categoria'])
            .toList();

        return ItemPlanejamento.fromMap(e as Map<String, dynamic>)
          ..copyWith(
            movimentos: movimentosDoIten,
            categoria: movimentosDoIten.first.categoria!,
          );
      }).toList();

      // alimenta o planejamento com os itens
      final planejamento =
          Planejamento.fromMap(planejamentoDataRaw as Map<String, dynamic>)
            ..copyWith(
              itens: itemPlanejamentoList,
            );

      return Right(planejamento);
    } catch (e) {
      await closeDb();
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
