part of 'conta_mostrar_na_tela_inicial_cubit.dart';

sealed class ContaMostrarNaTelaInicialState extends Equatable {
  const ContaMostrarNaTelaInicialState(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

final class ContaMostrarNaTelaInitial extends ContaMostrarNaTelaInicialState {
  const ContaMostrarNaTelaInitial(super.value);
}

final class ContaMostrarNaTelaChanged extends ContaMostrarNaTelaInicialState {
  const ContaMostrarNaTelaChanged(super.value);

  @override
  List<Object> get props => [value];
}
