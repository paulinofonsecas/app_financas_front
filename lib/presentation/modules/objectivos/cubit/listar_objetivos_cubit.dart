import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/domain/services/i_objetivo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'listar_objetivos_state.dart';

class ListarObjetivosCubit extends Cubit<ListarObjetivosState> {
  ListarObjetivosCubit(this._iObjectivoService)
      : super(ListarObjetivosInitial());

  final IObjectivoService _iObjectivoService;

  void loadData() async {
    emit(ListarObjetivosLoading());

    final result = await _iObjectivoService.listObjectivos();

    result.fold(
      (l) => emit(ListarObjetivosError(l.message)),
      (r) => emit(ListarObjetivosLoaded(objectivos: r)),
    );
  }
}
