import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class RegistarEntradaController extends GetxController {
  late final IMovimentoService movimentoService;
  late final SetupConfiguration setupConfiguration;

  late final TextEditingController descricaoTextController;
  late final TextEditingController dateTextController;
  late final TextEditingController valorTextController;
  late final TextEditingController obsTextController;

  var date = DateTime.now();
  late int categoriaMovimentoId;
  int? cartaoId;
  var salvandoMovimento = false.obs;
  var salvo = false;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    movimentoService = Get.find();
    setupConfiguration = Get.find();

    descricaoTextController = TextEditingController();
    dateTextController = TextEditingController();
    valorTextController = TextEditingController();
    obsTextController = TextEditingController();

    categoriaMovimentoId = getCategories().first.id;
    // cartaoId = getCards().first.id;
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

  Future<void> _setupOnSuccess() async {
    salvo = true;
    update();
    var homePageController = Get.find<HomePageController>();
    await homePageController.refreshSaldosDeCartoes();
    update();
  }

  Future<void> finalizarMovimento() async {
    salvandoMovimento.value = true;
    var valor = valorTextController.text;
    if (valor.isEmpty) {
      valor = '0';
    }

    var descricaoMovimento = descricaoTextController.text;
    var dateMovimento = date;
    var valorMovimento = double.parse(valor);
    var obsMovimento = obsTextController.text;

    if (descricaoMovimento.isEmpty) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Descrição do movimento',
          message: 'Preencha a descrição do movimento',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          isDismissible: true,
        ),
      );
      salvandoMovimento.value = false;
      return;
    }

    if (valorMovimento <= 0) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'valor a movimentar',
          message: 'Preencha o valor do movimento',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          isDismissible: true,
        ),
      );
      salvandoMovimento.value = false;
      return;
    }

    if (cartaoId == null) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Conta de destino',
          message: 'Preencha o valor do movimento',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          isDismissible: true,
        ),
      );
      salvandoMovimento.value = false;
      return;
    }

    var movimento = Movimento.make(
      valor: valorMovimento,
      data: dateMovimento,
      descricao: descricaoMovimento,
      cartaoId: cartaoId ?? 1,
      tipoMovimentoId: 1,
      categoriaMovimentoId: categoriaMovimentoId,
      obsMovimento: obsMovimento,
      confirmado: true,
    );

    var result = await movimentoService.saveMovimento(movimento);

    if (result is Right) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Sucesso',
          message: 'Movimento registrado com sucesso',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          isDismissible: true,
        ),
      );
      await _setupOnSuccess();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Erro',
          message: 'Erro ao registrar movimento',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          isDismissible: true,
        ),
      );
    }
    salvandoMovimento.value = false;
  }
}
