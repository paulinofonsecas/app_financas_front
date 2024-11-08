import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'criar_sub_categoria_state.dart';

class CriarSubCategoriaCubit extends Cubit<CriarSubCategoriaState> {
  CriarSubCategoriaCubit({
    required this.categoriaService,
    required this.tipoCategoria,
    this.subCategoria,
  }) : super(subCategoria == null
            ? CriarSubCategoriaInitial()
            : CriarSubCategoriaEdit(subCategoria));

  final ICategoriaUseCases categoriaService;
  final TipoCategoria tipoCategoria;
  final Categoria? subCategoria;

  void createSubCategoria(Categoria categoria, String subCategoriaDesc) async {
    emit(CriarSubCategoriaLoading());

    late final Either result;
    final newSubCategoria = Categoria.make(
      name: subCategoriaDesc,
      color: categoria.color,
    );

    if (subCategoria != null &&
        categoria.subCategorias
            .where((e) => e.id == subCategoria!.id)
            .isNotEmpty) {
      categoria.subCategorias.removeWhere((e) => e.id == subCategoria!.id);
    }

    categoria.subCategorias.add(newSubCategoria);

    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.editEntradaCategoria(categoria);
    } else {
      result = await categoriaService.editSaidaCategoria(categoria);
    }

    result.fold(
      (l) => emit(const CriarSubCategoriaFailed(
          'Ocorreu um erro ao salvar a subCategoria')),
      (r) => emit(CriarSubCategoriaSuccess()),
    );
  }

  void deleteSubCategoria(
      Categoria categoria, Categoria subCategoriaToDelete) async {
    emit(CriarSubCategoriaLoading());

    late final Either result;

    if (categoria.subCategorias
        .where((e) => e.id == subCategoriaToDelete.id)
        .isNotEmpty) {
      categoria.subCategorias
          .removeWhere((e) => e.id == subCategoriaToDelete.id);
    }

    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.editEntradaCategoria(categoria);
    } else {
      result = await categoriaService.editSaidaCategoria(categoria);
    }

    result.fold(
      (l) => emit(const CriarSubCategoriaFailed(
          'Ocorreu um erro ao salvar a subCategoria')),
      (r) => emit(CriarSubCategoriaSuccess()),
    );
  }
}
