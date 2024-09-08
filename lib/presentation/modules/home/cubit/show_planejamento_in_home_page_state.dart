part of 'show_planejamento_in_home_page_cubit.dart';

sealed class ShowPlanejamentoInHomePageState extends Equatable {
  const ShowPlanejamentoInHomePageState();

  @override
  List<Object> get props => [];
}

final class ShowPlanejamentoInHomePageInitial
    extends ShowPlanejamentoInHomePageState {}

final class ShowPlanejamentoInHomePageLoading
    extends ShowPlanejamentoInHomePageState {}

final class ShowPlanejamentoInHomePageEmpty
    extends ShowPlanejamentoInHomePageState {}

final class ShowPlanejamentoInHomePageError
    extends ShowPlanejamentoInHomePageState {
  const ShowPlanejamentoInHomePageError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class ShowPlanejamentoInHomePageSuccess
    extends ShowPlanejamentoInHomePageState {
  const ShowPlanejamentoInHomePageSuccess(this.planejamento);
  final Planejamento planejamento;

  @override
  List<Object> get props => [planejamento];
}
