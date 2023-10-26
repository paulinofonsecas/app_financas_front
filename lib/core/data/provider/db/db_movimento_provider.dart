import 'package:app_financas/core/data/provider/db/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class DbMovimentoProvider implements IMovimentoProvider {
  late Box<Map<dynamic, dynamic>> _movimentosBox;

  Future<void> _initDb() async {
    _movimentosBox = await Hive.openBox(kMovimentosBox);
  }

  @override
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) {
    // TODO: implement editMovimento
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Movimento>> getMovimento(int id) async {
    await _initDb();

    var data = _movimentosBox.get(id);

    if (data == null) {
      return Left(NotFoundError('Movimento não encontrado'));
    }

    var movimento = Movimento.fromMap(data.cast<String, dynamic>());
    return Right(movimento);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() async {
    await _initDb();
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
      await _initDb();
      var map = movimento.toMap();
      await _movimentosBox.put(movimento.id, map);

      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao salvar movimento'));
    }
  }
}
