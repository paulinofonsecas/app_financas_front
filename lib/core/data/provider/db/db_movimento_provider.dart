import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class DbMovimentoProvider implements IMovimentoProvider {
  late Box<Map<dynamic, dynamic>> _movimentosBox;

  Future<void> initDb() async {
    _movimentosBox = await Hive.openBox(kMovimentosBox);
  }

  Future<void> dispose() {
    return _movimentosBox.close();
  }

  @override
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) async {
    try {
      await initDb();

      if (movimento.valor < 0) {
        return Left(ValorInvalido('Saldo invalido ${movimento.valor}'));
      }

      movimento = movimento.copyWith(
        valor: movimento.valor,
        descricao: movimento.descricao,
        data: movimento.data,
        confirmado: movimento.confirmado,
        categoriaMovimentoId: movimento.categoriaMovimentoId,
        cartaoId: movimento.cartaoId,
        obsMovimento: movimento.obsMovimento,
      );

      var map = movimento.toMap();
      await _movimentosBox.put(movimento.id, map);

      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao salvar movimento'));
    }
  }

  @override
  Future<Either<Failure, Movimento>> getMovimento(int id) async {
    await initDb();

    var data = _movimentosBox.get(id);

    if (data == null) {
      return Left(NotFoundError('Movimento não encontrado'));
    }

    var movimento = Movimento.fromMap(data.cast<String, dynamic>());
    return Right(movimento);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() async {
    await initDb();
    var data = _movimentosBox.toMap();
    var movimentos = data.values
        .map<Movimento>(
          (e) => Movimento.fromMap(e.cast<String, dynamic>()),
        )
        .toList();
    return Right(movimentos);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date) {
    // TODO: implement listMovimentosAt
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(
      int page, int pageSize) {
    // TODO: implement listPaginatedMovimentos
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento) async {
    try {
      await initDb();

      var lastId = 1;

      if (_movimentosBox.values.isNotEmpty) {
        lastId = _movimentosBox.keys.last + 1;
      }

      movimento = movimento.copyWith(id: lastId);
      var map = movimento.toMap();
      await _movimentosBox.put(lastId, map);

      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao salvar movimento'));
    }
  }

  @override
  Future<Either<Failure, double>> getSaldo(int contaId) async {
    await initDb();

    var result = await listMovimentos();

    if (result.isRight()) {
      var movimentos = result.getOrElse(() => []);

      var entradas = 0.0;
      var saidas = 0.0;

      for (var mov in movimentos) {
        if (mov.tipoMovimentoId == 1) {
          entradas += mov.valor;
        } else {
          saidas += mov.valor;
        }
      }

      var saldo = entradas - saidas;

      return Right(saldo);
    } else {
      return Left(Failure('Erro ao processar o saldo da conta'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMovimento(int id) async {
    try {
      await initDb();

      await _movimentosBox.delete(id);
      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao deletar movimento'));
    }
  }
}
