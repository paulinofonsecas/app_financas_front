// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/score/domain/services/i_categoria_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'categoria_event.dart';
part 'categoria_state.dart';

class CategoriaBloc extends Bloc<CategoriaEvent, CategoriaState> {
  late final ICategoriaService _categoriaService;

  CategoriaBloc(this._categoriaService) : super(CategoriaInitial()) {
    on<GetCategoriaByIdEvent>(_onCategoriaCategoriaByIdEvent);
  }

  void _onCategoriaCategoriaByIdEvent(GetCategoriaByIdEvent event, emit) {
    emit(CategoriaLoading());

    if (event.categoriaTipoId == 1) {
      _categoriaService.getEntradaCategoria(event.id).then((value) {
        if (value is Right) {
          emit(CategoriaSuccess(value.getOrElse(() => Categoria.fake())));
        } else {
          emit(const CategoriaError('Erro ao buscar categoria'));
        }
      });
    } else {
      _categoriaService.getSaidaCategoria(event.id).then((value) {
        if (value is Right) {
          emit(CategoriaSuccess(value.getOrElse(() => Categoria.fake())));
        } else {
          emit(const CategoriaError('Erro ao buscar categoria'));
        }
      });
    }
  }
}
