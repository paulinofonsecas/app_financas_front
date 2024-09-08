part of 'create_planejamento_cubit.dart';

sealed class CreatePlanejamentoState extends Equatable {
  const CreatePlanejamentoState(this.planejamento);

  final Planejamento planejamento;

  // copyWith

  CreatePlanejamentoState copyWith({
    Planejamento? planejamento,
  }) {
    return CreatePlanejamentoInitial(
      planejamento ?? this.planejamento,
    );
  }

  @override
  List<Object> get props => [planejamento];
}

class CreatePlanejamentoInitial extends CreatePlanejamentoState {
  const CreatePlanejamentoInitial(
    super.planejamento,
  );
}
