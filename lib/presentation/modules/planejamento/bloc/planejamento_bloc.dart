import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'planejamento_event.dart';
part 'planejamento_state.dart';

class PlanejamentoBloc extends Bloc<PlanejamentoEvent, PlanejamentoState> {
  PlanejamentoBloc() : super(const PlanejamentoInitial()) {
    on<CustomPlanejamentoEvent>(_onCustomPlanejamentoEvent);
  }

  FutureOr<void> _onCustomPlanejamentoEvent(
    CustomPlanejamentoEvent event,
    Emitter<PlanejamentoState> emit,
  ) {
    // TODO: Add Logic
  }
}
