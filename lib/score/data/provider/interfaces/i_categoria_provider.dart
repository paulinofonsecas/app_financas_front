import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoriaProvider {
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas();
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas();
  Future<Either<Failure, List<Categoria>>> listValidCategoriasEntradas();
  Future<Either<Failure, List<Categoria>>> listValidCategoriasSaidas();
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasSaidas();
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasEntradas();
  Future<Either<Failure, bool>> saveEntradaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> saveSaidaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> editEntradaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> editSaidaCategoria(Categoria categoria);
  Future<Either<Failure, List<Categoria>>> listCategorias();
  Future<Either<Failure, Categoria>> getEntradaCategoria(int id);
  Future<Either<Failure, Categoria>> getSaidaCategoria(int id);
  Future<Either<Failure, bool>> arquivarCategoriaEntrada(int categoriaId);
  Future<Either<Failure, bool>> arquivarCategoriaSaida(int categoriaId);
  Future<Either<Failure, bool>> desarquivarCategoriaEntrada(int categoriaId);
  Future<Either<Failure, bool>> desarquivarCategoriaSaida(int categoriaId);
}
