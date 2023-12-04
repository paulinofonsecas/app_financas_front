import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import 'confirmar_transacao_cubit.dart';

part 'select_data_state.dart';

class SelectDataCubit extends Cubit<SelectDataState> {
  SelectDataCubit() : super(SelectDataInitial(DateTime.now()));

  void selecionarDateTime(
    BuildContext context,
    ConfirmarTransacaoCubit confirmTransacaoCubit,
  ) async {
    var date = state is SelectDataSuccess
        ? (state as SelectDataSuccess).date
        : DateTime.now();

    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: true,
      initialDate: date,
      isForce2Digits: true,
    );

    if (dateTime != null) {
      date = dateTime;

      var confirmado = confirmTransacaoCubit.state.isTransacaoConfirmad;

      if (confirmado && dateTime.isAfter(DateTime.now())) {
        confirmTransacaoCubit.changeConfirmarTransacao();
      }

      emit(SelectDataSuccess(date));
    }
  }
}
