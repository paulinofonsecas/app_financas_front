// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_list_categorias_state.dart';

class SearchListCategoriasCubit extends Cubit<SearchListCategoriasState> {
  SearchListCategoriasCubit() : super(SearchListCategoriasInitial()) {
    _iCategoriaService = getIt();
  }

  late final ICategoriaService _iCategoriaService;

  void loadCategoriaList() async {
    emit(SearchListCategoriasLoading());

    final result = await _iCategoriaService.listValidCategoriasSaidas();

    if (result is Right) {
      var lista = result.getOrElse(() => []);

      if (lista.isEmpty) {
        emit(SearchListCategoriasEmpty());
      } else {
        emit(SearchListCategoriasLoaded(categorias: lista));
      }
    } else {
      emit(SearchListCategoriasError());
    }
  }
}
