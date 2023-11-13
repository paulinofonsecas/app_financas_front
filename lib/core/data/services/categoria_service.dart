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
  Future<Either<Failure, Categoria>> getEntradaCategoria(int id) {
    return provider.getEntradaCategoria(id);
  }

  @override
  Future<Either<Failure, Categoria>> getSaidaCategoria(int id) {
    return provider.getSaidaCategoria(id);
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategorias() {
    return provider.listCategorias();
  }

  @override
  Future<Either<Failure, bool>> editEntradaCategoria(Categoria categoria) {
    return provider.editEntradaCategoria(categoria);
  }

  @override
  Future<Either<Failure, bool>> editSaidaCategoria(Categoria categoria) {
    return provider.editSaidaCategoria(categoria);
  }

  @override
  Future<Either<Failure, bool>> arquivarCategoriaEntrada(int categoriaId) {
    return provider.arquivarCategoriaEntrada(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> arquivarCategoriaSaida(int categoriaId) {
    return provider.arquivarCategoriaSaida(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> desarquivarCategoriaEntrada(int categoriaId) {
    return provider.desarquivarCategoriaEntrada(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> desarquivarCategoriaSaida(int categoriaId) {
    return provider.desarquivarCategoriaSaida(categoriaId);
  }

  @override
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasEntradas() {
    return provider.listArchivedCategoriasEntradas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasSaidas() {
    return provider.listArchivedCategoriasSaidas();
  }
}
