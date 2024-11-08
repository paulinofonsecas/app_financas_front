import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';

import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'listar_categoria_state.dart';

class ListarCategoriaCubit extends Cubit<ListarCategoriaState> {
  late final ICategoriaUseCases _iCategoriaService;

  ListarCategoriaCubit() : super(ListarCategoriaInitial()) {
    _iCategoriaService = getIt();
  }

  void listarCategorias(
    TipoCategoria tipo,
  ) async {
    emit(ListarCategoriasLoading());

    late Either<Failure, List<Categoria>> result;

    if (tipo == TipoCategoria.entrada) {
      result = await _iCategoriaService.listValidCategoriasEntradas();
    } else {
      result = await _iCategoriaService.listValidCategoriasSaidas();
    }

    if (result is Right) {
      var lista = result.getOrElse(() => []);

      if (lista.isEmpty) {
        emit(ListarCategoriasEmpty());
      } else {
        emit(ListarCategoriasSuccess(lista));
      }
    } else {
      emit(ListarCategoriasError());
    }
  }
}
