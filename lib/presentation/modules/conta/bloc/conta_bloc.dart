import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'conta_event.dart';
part 'conta_state.dart';

class ContaBloc extends Bloc<ContaEvent, ContaState> {
  ContaBloc() : super(const ContaInitial()) {
    on<CustomContaEvent>(_onCustomContaEvent);
  }

  FutureOr<void> _onCustomContaEvent(
    CustomContaEvent event,
    Emitter<ContaState> emit,
  ) {
    // TODO: Add Logic
  }
}
