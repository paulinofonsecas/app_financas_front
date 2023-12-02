import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mostrar_na_tela_inicial_state.dart';

class MostrarNaTelaInicialCubit extends Cubit<MostrarNaTelaInicialState> {
  MostrarNaTelaInicialCubit() : super(const MostrarNaTelaInicialChanged(true));

  void changeMostrarNaTelaicial() {
    emit(MostrarNaTelaInicialChanged(!state.mostrarNaTelaicial));
  }
}
