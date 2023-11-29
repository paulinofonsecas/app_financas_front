import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tipo_conta_state.dart';

class TipoContaCubit extends Cubit<TipoContaState> {
  TipoContaCubit() : super(TipoContaInitial());

  void changeTipoConta(int tipoContaId) {
    emit(TipoContaChanged(tipoContaId));

    // TODO: implementar a logica de comunicacao com o BLoC
  }
}
