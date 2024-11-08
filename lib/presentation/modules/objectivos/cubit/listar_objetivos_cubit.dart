import 'package:app_financas/score/domain/entitys/objectivo.dart';
import 'package:app_financas/score/domain/services/i_objetivo_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      (r) => r.isEmpty
          ? emit(ListarObjetivosEmpty())
          : emit(ListarObjetivosLoaded(objectivos: r)),
    );
  }
}
