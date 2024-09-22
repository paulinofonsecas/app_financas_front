import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class DbMovimentoProvider implements IMovimentoProvider {
  late Box<Map<dynamic, dynamic>> _movimentosBox;
  late final ICategoriaService categoriaService;
  final List<Function> _listeners = [];

  DbMovimentoProvider(this.categoriaService);

  Future<void> initDb() async {
    _movimentosBox = await Hive.openBox(kMovimentosBox);
  }

  Future<void> dispose() {
    return _movimentosBox.close();
  }

  @override
  void addListener(Function fn) {
    _listeners.add(fn);
  }

  @override
  void removeListener(Function fn) {
    _listeners.remove(fn);
  }

  @override
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) async {
    try {
      await initDb();

      if (movimento.valor < 0) {
        return Left(ValorInvalido('Saldo invalido ${movimento.valor}'));
      }

      // if (!(await saldoIsSuficiente(movimento))) {
      //   return Left(SaldoInsuficiente('Saldo insuficiente'));
      // }

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

      _globalUpdate();

      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao salvar movimento'));
    }
  }

  void _globalUpdate() {
    for (var element in _listeners) {
      element();
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

    movimentos = await populateCategories(movimentos);

    return Right(movimentos);
  }

  Future<List<Movimento>> populateCategories(List<Movimento> movimentos) async {
    var saida = <Movimento>[];

    for (var mov in movimentos) {
      var result = mov.tipoMovimentoId == 1
          ? await categoriaService.getEntradaCategoria(mov.categoriaMovimentoId)
          : await categoriaService.getSaidaCategoria(mov.categoriaMovimentoId);
      var categoria = result.getOrElse(() => Categoria.fake());

      if (mov.categoriaMovimentoId == 303030) {
        categoria = Categoria.ajuste(mov.tipoMovimentoId);
      }

      if (mov.categoriaMovimentoId == 303040) {
        categoria = Categoria.ajuste(mov.tipoMovimentoId);
      }

      saida.add(mov.copyWith(categoria: categoria));
    }

    return saida;
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

  Future<bool> saldoIsSuficiente(Movimento movimento) async {
    if (movimento.tipoMovimentoId == 1 || !movimento.confirmado) {
      return true;
    }

    IContaProvider contaService = getIt();
    var result = await contaService.getConta(movimento.cartaoId);

    if (result is Right) {
      var conta = result.getOrElse(() => Conta.fake());
      return conta.saldo >= movimento.valor;
    } else {
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento) async {
    try {
      await initDb();

      late int lastId;
      if (movimento.id <= 0) {
        lastId = 1;

        if (_movimentosBox.values.isNotEmpty) {
          lastId = _movimentosBox.keys.last + 1;
        }
      } else {
        lastId = movimento.id;
      }

      // if (!(await saldoIsSuficiente(movimento))) {
      //   return Left(SaldoInsuficiente('Saldo insuficiente'));
      // }

      movimento = movimento.copyWith(id: lastId);
      var map = movimento.toMap();
      await _movimentosBox.put(lastId, map);

      _globalUpdate();

      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao salvar movimento ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMovimento(int id) async {
    try {
      await initDb();

      await _movimentosBox.delete(id);
      _globalUpdate();

      return const Right(true);
    } catch (e) {
      return Left(HttpException('Erro ao deletar movimento'));
    }
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedContaMovimentos(
      int currentIndex, int page, int pageSize) {
    // TODO: implement listPaginatedMovimentos
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosEntrada(
      {DateTime? date}) async {
    await initDb();
    var data = _movimentosBox.toMap();

    var movimentos = data.values
        .map<Movimento>(
          (e) => Movimento.fromMap(e.cast<String, dynamic>()),
        )
        .where((element) => element.tipoMovimentoId == 1 && element.confirmado)
        .toList();

    if (date != null) {
      movimentos = movimentos
          .where((element) =>
              element.data.year == date.year &&
              element.data.month == date.month)
          .toList();
    }

    movimentos = await populateCategories(movimentos);

    return Right(movimentos);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosSaida(
      {DateTime? date}) async {
    await initDb();
    var data = _movimentosBox.toMap();

    var movimentos = data.values
        .map<Movimento>(
          (e) => Movimento.fromMap(e.cast<String, dynamic>()),
        )
        .where((element) => element.tipoMovimentoId == 2 && element.confirmado)
        .toList();

    if (date != null) {
      movimentos = movimentos
          .where((element) =>
              element.data.year == date.year &&
              element.data.month == date.month)
          .toList();
    }

    movimentos = await populateCategories(movimentos);

    return Right(movimentos);
  }

  @override
  Future<Either<Failure, List<Movimento>>> transferirMovimentos(
    List<Movimento> movimentos,
    int destinoId,
  ) async {
    try {
      await initDb();
      final saida = <Movimento>[];

      for (var movimento in movimentos) {
        final data = movimento.copyWith(cartaoId: destinoId);

        saida.add(data);
        await _movimentosBox.put(
          movimento.id,
          data.toMap(),
        );
      }

      _globalUpdate();

      return const Right([]);
    } catch (e) {
      return Left(HttpException('Erro ao transferir movimentos'));
    }
  }
}
