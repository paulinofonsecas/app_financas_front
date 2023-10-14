import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MovimentoScreenController extends GetxController {
  late final IMovimentoService service;
  late DateTime date;

  @override
  void onInit() {
    service = Get.find();

    date = DateTime.now();
    super.onInit();
  }

  Future<Either<Failure, List<Movimento>>> listMovimentos() {
    if (date.day == DateTime.now().day) {
      return service.listMovimentos();
    } else {
      return service.listMovimentosAt(date);
    }
  }

  void selecionarDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: true,
      type: OmniDateTimePickerType.date,
    );

    if (dateTime != null) {
      if (dateTime.isAfter(DateTime.now())) {
        Get.snackbar(
          'Data inválida',
          'A data não pode ser menor que a data atual',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      date = dateTime;
      update();
    }
  }
}
