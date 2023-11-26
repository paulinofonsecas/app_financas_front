import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'conta_periodo_picker_cubit_state.dart';

class ContaPeriodoPickerCubit extends Cubit<ContaPeriodoPickerState> {
  ContaPeriodoPickerCubit()
      : super(ContaPeriodoPickerInitial(DateTime.now().month));

  void changeMes(int mes) {
    emit(ContaPeriodoPickerChanged(mes));
  }

  void nextMonth() {
    if (state.mes >= 12) {
      return;
    }
    emit(ContaPeriodoPickerChanged(state.mes + 1));
  }

  void previousMonth() {
    if (state.mes <= 1) {
      return;
    }
    emit(ContaPeriodoPickerChanged(state.mes - 1));
  }
}
