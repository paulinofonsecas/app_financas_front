import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'criar_categoria_state.dart';

class CriarCategoriaCubit extends Cubit<CriarCategoriaState> {
  CriarCategoriaCubit(this.categoriaService, this.tipoCategoria)
      : super(CriarCategoriaInitial());

  final ICategoriaService categoriaService;
  final TipoCategoria tipoCategoria;

  Future<void> cadastrarCategoria(
    String nome,
    Color color,
    IconData icon,
  ) async {
    if (nome.isEmpty) {
      showErrorMessage('Erro', 'Preencha o campo nome');
    }

    var categoria = Categoria.make(
      name: nome,
      color: color,
      icon: icon,
    );

    late Either<Exception, bool> result;

    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.saveEntradaCategoria(categoria);
    } else {
      result = await categoriaService.saveSaidaCategoria(categoria);
    }

    result.fold(
      (l) => emit(CriarCategoriaError()),
      (r) => emit(CriarCategoriaSuccess()),
    );
  }
}
