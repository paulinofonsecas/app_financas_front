import 'package:app_financas/presentation/modules/estatisticas/widgets/filtro_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filtro_state.dart';

class FiltroCubit extends Cubit<FiltroState> {
  FiltroCubit() : super(const FiltroChanged(FiltroSelectedType.mes));

  void changeFiltro(FiltroSelectedType filtro) {
    emit(FiltroChanged(filtro));
  }
}
