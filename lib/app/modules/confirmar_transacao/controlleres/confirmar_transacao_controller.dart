import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:app_financas/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ConfirmarTransacaoController extends GetxController {
  late final IMovimentoService movimentoService;
  late final TextEditingController valorTextController;
  late Movimento movimento;
  late DateTime date;
  var alterandoTransacao = false.obs;

  ConfirmarTransacaoController(this.movimento) {
    date = movimento.data;
  }

  @override
  void onInit() {
    movimentoService = Get.find();
    valorTextController =
        TextEditingController(text: movimento.valor.toString());
    super.onInit();
  }

  String getSelectedDate() {
    return verboseDateFormat.format(date);
  }

  void setMovimento(Movimento movimento) {
    this.movimento = movimento;
    valorTextController.text = movimento.valor.toString();
  }

  String onValorChange(value) {
    return value;
  }

  void selecionarDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: true,
    );

    if (dateTime != null) {
      date = dateTime;
      update();
    }
  }

  Future<void> alterarTransacao() async {
    alterandoTransacao.value = true;
    var valor = valorTextController.text;
    if (valor.isEmpty) {
      valor = '0';
    }

    var dateMovimento = date;
    var valorMovimento = double.parse(valor);

    if (valorMovimento <= 0) {
      showErrorMessage('Error', 'Preencha o valor do movimento');
      alterandoTransacao.value = false;
      return;
    }

    var myMovimento = movimento.copyWith(
      valor: valorMovimento,
      data: dateMovimento,
      confirmado: true,
    );

    var result = await movimentoService.editMovimento(myMovimento);

    if (result is Right && result.getOrElse(() => false)) {
      dynamic result0 = await movimentoService.getMovimento(movimento.id);
      result0 = result0.getOrElse(() => Movimento.fake());

      Get.back();
    } else {
      if (result is Left &&
          result.swap().getOrElse(() => HttpException('message'))
              is SaldoInsuficiente) {
        showErrorMessage('Erro', 'Saldo insuficiente na conta selecionada');
      } else {
        var error = result.swap().getOrElse(() => HttpException('message'));
        if (kDebugMode) {
          print(error.message);
        }
        showErrorMessage('Erro', 'Erro desconhecido ao atualizar a transação');
      }
      alterandoTransacao.value = false;
    }
  }
}
