import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_categoria_state.dart';

class SelectCategoriaCubit extends Cubit<SelectCategoriaState> {
  late final ICategoriaService _categoriaService;
  SelectCategoriaCubit() : super(SelectCategoriaInitial()) {
    _categoriaService = getIt();
  }

  void selectedCategoria(Categoria categoria) {
    emit(SelectCategoriaChanged(categoria));
  }

  void selectDefaultCategoria(bool isEntrada) async {
    emit(SelectCategoriaLoading());

    var result = await (isEntrada
        ? _categoriaService.listCategoriasEntradas()
        : _categoriaService.listCategoriasSaidas());

    if (result is Right) {
      emit(SelectCategoriaChanged(result.getOrElse(() => []).first));
    } else {
      emit(SelectCategoriaError());
    }
  }
}
