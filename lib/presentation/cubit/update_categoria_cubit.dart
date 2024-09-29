import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'update_categoria_state.dart';

class UpdateCategoriaCubit extends Cubit<UpdateCategoriaState> {
  UpdateCategoriaCubit({
    required this.categoriaService,
    required this.tipoCategoria,
  }) : super(UpdateCategoriaInitial());

  final ICategoriaService categoriaService;
  final TipoCategoria tipoCategoria;

  void updateCategoria(Categoria oldCategoria) async {
    emit(UpdateCategoriaLoading());

    late Either result;
    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.getEntradaCategoria(oldCategoria.id);
    } else {
      result = await categoriaService.getSaidaCategoria(oldCategoria.id);
    }

    result.fold(
      (l) => emit(UpdateCategoriaFailed()),
      (r) => emit(UpdateCategoriaSuccess(r)),
    );
  }
}
