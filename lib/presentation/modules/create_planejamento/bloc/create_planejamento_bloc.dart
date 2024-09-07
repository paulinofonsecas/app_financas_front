import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'create_planejamento_event.dart';
part 'create_planejamento_state.dart';

class CreatePlanejamentoBloc extends Bloc<CreatePlanejamentoEvent, CreatePlanejamentoState> {
  CreatePlanejamentoBloc() : super(const CreatePlanejamentoInitial()) {
    on<CustomCreatePlanejamentoEvent>(_onCustomCreatePlanejamentoEvent);
  }

  FutureOr<void> _onCustomCreatePlanejamentoEvent(
    CustomCreatePlanejamentoEvent event,
    Emitter<CreatePlanejamentoState> emit,
  ) {
    // TODO: Add Logic
  }
}
