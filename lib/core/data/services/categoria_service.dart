import 'package:app_financas/core/data/provider/interfaces/i_categoria_provider.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

class CategoriaService extends ICategoriaService {
  final ICategoriaProvider provider;

  CategoriaService(this.provider);

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas() {
    return provider.listCategoriasEntradas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas() {
    return provider.listCategoriasSaidas();
  }

  @override
  Future<Either<Failure, bool>> saveEntradaCategoria(Categoria categoria) {
    return provider.saveEntradaCategoria(categoria);
  }

  @override
  Future<Either<Failure, bool>> saveSaidaCategoria(Categoria categoria) {
    return provider.saveSaidaCategoria(categoria);
  }

  @override
  Future<Either<Failure, Categoria>> getCategoria(int id) {
    return provider.getCategoria(id);
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategorias() {
    return provider.listCategorias();
  }
}
