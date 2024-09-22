import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'descricao_text_state.dart';

class DescricaoTextCubit extends Cubit<DescricaoTextState> {
  DescricaoTextCubit(String? descricao)
      : super(DescricaoTextInitial(descricao ?? ''));

  void changeText(String valor) {
    if (valor.isEmpty) {
      return;
    }
    emit(DescricaoTextChanged(valor));
  }
}
