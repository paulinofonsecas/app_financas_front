import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'objectivos_event.dart';
part 'objectivos_state.dart';

class ObjectivosBloc extends Bloc<ObjectivosEvent, ObjectivosState> {
  ObjectivosBloc() : super(const ObjectivosInitial()) {
    on<CustomObjectivosEvent>(_onCustomObjectivosEvent);
  }

  FutureOr<void> _onCustomObjectivosEvent(
    CustomObjectivosEvent event,
    Emitter<ObjectivosState> emit,
  ) {
    // TODO: Add Logic
  }
}
