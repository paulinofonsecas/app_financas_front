part of 'mostrar_na_tela_inicial_cubit.dart';

sealed class MostrarNaTelaInicialState extends Equatable {
  const MostrarNaTelaInicialState(this.mostrarNaTelaicial);

  final bool mostrarNaTelaicial;

  @override
  List<Object> get props => [];
}

final class MostrarNaTelaInicialChanged extends MostrarNaTelaInicialState {
  const MostrarNaTelaInicialChanged(super.mostrarNaTelaicial);

  @override
  List<Object> get props => [mostrarNaTelaicial];
}
