import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'periodo_planejamento_state.dart';

class PeriodoPlanejamentoCubit extends Cubit<PeriodoPlanejamentoState> {
  PeriodoPlanejamentoCubit()
      : super(
          PeriodoPlanejamentoInitial(
            DateTime.now(),
          ),
        );

  void nextMonth() {
    if (state.periodo.year == DateTime.now().year &&
        state.periodo.month == DateTime.now().month) {
      return;
    }

    late final DateTime nextDate;
    if (state.periodo.month == DateTime.december) {
      nextDate = state.periodo.copyWith(
        month: 1,
        year: state.periodo.year + 1,
      );
    } else {
      nextDate = state.periodo.copyWith(
        month: state.periodo.month + 1,
      );
    }

    emit(
      PeriodoPlanejamentoChangeMonth(
        nextDate,
      ),
    );
  }

  void previousMonth() {
    late final DateTime previousDate;
    if (state.periodo.month == DateTime.january) {
      previousDate = state.periodo.copyWith(
        month: 12,
        year: state.periodo.year - 1,
      );
    } else {
      previousDate = state.periodo.copyWith(
        month: state.periodo.month - 1,
      );
    }

    emit(
      PeriodoPlanejamentoChangeMonth(
        previousDate,
      ),
    );
  }

  void setPeriodo(DateTime dateTime) {
    emit(
      PeriodoPlanejamentoChangeMonth(
        dateTime,
      ),
    );
  }
}
