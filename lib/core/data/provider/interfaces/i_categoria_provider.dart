import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoriaProvider {
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas();
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas();
  Future<Either<Failure, bool>> saveEntradaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> saveSaidaCategoria(Categoria categoria);
  Future<Either<Failure, List<Categoria>>> listCategorias();
  Future<Either<Failure, Categoria>> getCategoria(int id);
}
