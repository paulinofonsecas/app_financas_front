import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'obs_text_state.dart';

class ObsTextCubit extends Cubit<ObsTextState> {
  ObsTextCubit() : super(const ObsTextInitial(''));

  changeText(String v) {
    if (v.isNotEmpty) {
      emit(ObsTextChanged(v));
    }
  }
}
