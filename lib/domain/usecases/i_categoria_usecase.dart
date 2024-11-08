import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/repositories/i_categoria_repository.dart';

import 'package:dartz/dartz.dart';

abstract class ICategoriaUseCases {
  Future<Either<Failure, Categoria>> getEntradaCategoria(int id);
  Future<Either<Failure, Categoria>> getSaidaCategoria(int id);
  Future<Either<Failure, List<Categoria>>> listCategorias();
  Future<Either<Failure, List<Categoria>>> listValidCategoriasEntradas();
  Future<Either<Failure, List<Categoria>>> listValidCategoriasSaidas();
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas();
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas();
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasSaidas();
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasEntradas();
  Future<Either<Failure, bool>> saveEntradaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> saveSaidaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> editEntradaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> editSaidaCategoria(Categoria categoria);
  Future<Either<Failure, bool>> arquivarCategoriaEntrada(int categoriaId);
  Future<Either<Failure, bool>> arquivarCategoriaSaida(int categoriaId);
  Future<Either<Failure, bool>> desarquivarCategoriaEntrada(int categoriaId);
  Future<Either<Failure, bool>> desarquivarCategoriaSaida(int categoriaId);
}

class CategoriaUseCases implements ICategoriaUseCases {
  final ICategoriaRepository _repository;

  CategoriaUseCases(this._repository);

  @override
  Future<Either<Failure, bool>> arquivarCategoriaEntrada(int categoriaId) {
    return _repository.arquivarCategoriaEntrada(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> arquivarCategoriaSaida(int categoriaId) {
    return _repository.arquivarCategoriaSaida(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> desarquivarCategoriaEntrada(int categoriaId) {
    return _repository.desarquivarCategoriaEntrada(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> desarquivarCategoriaSaida(int categoriaId) {
    return _repository.desarquivarCategoriaSaida(categoriaId);
  }

  @override
  Future<Either<Failure, bool>> editEntradaCategoria(Categoria categoria) {
    return _repository.editEntradaCategoria(categoria);
  }

  @override
  Future<Either<Failure, bool>> editSaidaCategoria(Categoria categoria) {
    return _repository.editSaidaCategoria(categoria);
  }

  @override
  Future<Either<Failure, Categoria>> getEntradaCategoria(int id) {
    return _repository.getEntradaCategoria(id);
  }

  @override
  Future<Either<Failure, Categoria>> getSaidaCategoria(int id) {
    return _repository.getSaidaCategoria(id);
  }

  @override
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasEntradas() {
    return _repository.listArchivedCategoriasEntradas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listArchivedCategoriasSaidas() {
    return _repository.listArchivedCategoriasSaidas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategorias() {
    return _repository.listCategorias();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasEntradas() {
    return _repository.listCategoriasEntradas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listCategoriasSaidas() {
    return _repository.listCategoriasSaidas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listValidCategoriasEntradas() {
    return _repository.listValidCategoriasEntradas();
  }

  @override
  Future<Either<Failure, List<Categoria>>> listValidCategoriasSaidas() {
    return _repository.listValidCategoriasSaidas();
  }

  @override
  Future<Either<Failure, bool>> saveEntradaCategoria(Categoria categoria) {
    return _repository.saveEntradaCategoria(categoria);
  }

  @override
  Future<Either<Failure, bool>> saveSaidaCategoria(Categoria categoria) {
    return _repository.saveSaidaCategoria(categoria);
  }
}
