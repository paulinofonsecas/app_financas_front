// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_list_categorias_state.dart';

class SearchListCategoriasCubit extends Cubit<SearchListCategoriasState> {
  SearchListCategoriasCubit() : super(SearchListCategoriasInitial()) {
    _iCategoriaService = getIt();
  }

  late final ICategoriaUseCases _iCategoriaService;

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
