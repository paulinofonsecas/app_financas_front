import 'dart:io';

import 'package:app_financas/app/modules/splash/splash_page.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class EditTransacaoController extends GetxController {
  late final IMovimentoService movimentoService;
  late final SetupConfiguration setupConfiguration;

  late final TextEditingController descricaoTextController;
  late final TextEditingController dateTextController;
  late final TextEditingController valorTextController;
  late final TextEditingController obsTextController;
  int movimentoType;
  late Movimento movimento;
  var confirmado = true.obs;

  var date = DateTime.now();
  late int categoriaMovimentoId;
  late int cartaoId;
  var alterandoTransacao = false.obs;
  var salvo = false;

  EditTransacaoController(
      {required this.movimentoType, required this.movimento});

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    movimentoService = Get.find();
    setupConfiguration = Get.find();

    descricaoTextController = TextEditingController(text: movimento.descricao);
    dateTextController = TextEditingController(text: getSelectedDate());
    valorTextController =
        TextEditingController(text: movimento.valor.toString());
    obsTextController = TextEditingController(text: movimento.obsMovimento);

    categoriaMovimentoId = movimento.categoriaMovimentoId;
    cartaoId = movimento.cartaoId;
    date = movimento.data;
    confirmado.value = movimento.confirmado;
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
      dateTextController.text = getSelectedDate();
      update();
    }
  }

  String getSelectedDate() {
    return verboseDateFormat.format(date);
  }

  List<CategoriaMovimento> getCategories() {
    return setupConfiguration.categorias;
  }

  List<Cartao> getCards() {
    return setupConfiguration.cartoes;
  }

  Future<void> alterarTransacao() async {
    alterandoTransacao.value = true;
    var valor = valorTextController.text;
    if (valor.isEmpty) {
      valor = '0';
    }

    var descricaoMovimento = descricaoTextController.text;
    var dateMovimento = date;
    var valorMovimento = double.parse(valor);
    var obsMovimento = obsTextController.text;

    if (descricaoMovimento.isEmpty) {
      showErrorMessage('Error', 'Preencha a descrição do movimento');
      alterandoTransacao.value = false;
    }

    if (valorMovimento <= 0) {
      showErrorMessage('Error', 'Preencha o valor do movimento');
      alterandoTransacao.value = false;
      return;
    }

    var myMovimento = Movimento.make(
      id: movimento.id,
      valor: valorMovimento,
      data: dateMovimento,
      descricao: descricaoMovimento,
      cartaoId: cartaoId,
      tipoMovimentoId: movimentoType,
      categoriaMovimentoId: categoriaMovimentoId,
      obsMovimento: obsMovimento,
      confirmado: confirmado.value,
    );

    var result = await movimentoService.editMovimento(myMovimento);

    if (result is Right && result.getOrElse(() => false)) {
      dynamic result0 = await movimentoService.getMovimento(movimento.id);
      result0 = result0.getOrElse(() => Movimento.fake());

      // showSucessMessage('Sucesso', 'Transação alterada com sucesso');
      if (result0 != Movimento.fake()) {
        movimento = result0;
        salvo = true;
      } else {
        salvo = false;
      }
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

  void switchTransactionType() {
    movimentoType = movimentoType == 1 ? 2 : 1;
    update(['geral']);
  }

  void showErrorMessage(String title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        isDismissible: true,
      ),
    );
  }

  void showSucessMessage(String title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        isDismissible: true,
      ),
    );
  }
}
