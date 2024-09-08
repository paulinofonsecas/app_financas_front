part of 'create_planejamento_stepper_controll_cubit.dart';

sealed class CreatePlanejamentoStepperControllState extends Equatable {
  const CreatePlanejamentoStepperControllState();

  @override
  List<Object> get props => [];
}

final class CreatePlanejamentoStepperControllInitial
    extends CreatePlanejamentoStepperControllState {}

final class CreatePlanejamentoStepperControllNext
    extends CreatePlanejamentoStepperControllState {
  final DateTime now;

  CreatePlanejamentoStepperControllNext() : now = DateTime.now();

  @override
  List<Object> get props => [now];
}

final class CreatePlanejamentoStepperControllBack
    extends CreatePlanejamentoStepperControllState {
  final DateTime now;
  CreatePlanejamentoStepperControllBack() : now = DateTime.now();

  @override
  List<Object> get props => [now];
}
