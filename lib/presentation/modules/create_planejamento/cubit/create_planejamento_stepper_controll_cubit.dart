import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_planejamento_stepper_controll_state.dart';

class CreatePlanejamentoStepperControllCubit
    extends Cubit<CreatePlanejamentoStepperControllState> {
  CreatePlanejamentoStepperControllCubit()
      : super(CreatePlanejamentoStepperControllInitial());

  void next() {
    emit(CreatePlanejamentoStepperControllNext());
  }

  void back() {
    emit(CreatePlanejamentoStepperControllBack());
  }
}
