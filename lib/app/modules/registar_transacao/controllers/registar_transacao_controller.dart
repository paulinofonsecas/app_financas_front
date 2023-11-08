import 'package:app_financas/app/components/categoria_bottom_components/bottom_category_component.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class RegistarTransacaoController extends GetxController {
  late final IMovimentoService movimentoService;
  late final ICategoriaService categoriaService;
  late final SetupConfiguration setupConfiguration;

  late final TextEditingController descricaoTextController;
  late final TextEditingController dateTextController;
  late final TextEditingController valorTextController;
  late final TextEditingController obsTextController;
  int movimentoType;
  var confirmado = true.obs;

  var date = DateTime.now();
  late int categoriaMovimentoId;
  late int cartaoId;
  var salvandoMovimento = false.obs;
  var salvo = false;

  RegistarTransacaoController({required this.movimentoType});

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    movimentoService = Get.find();
    categoriaService = Get.find();
    setupConfiguration = Get.find();

    descricaoTextController = TextEditingController();
    dateTextController = TextEditingController();
    valorTextController = TextEditingController();
    obsTextController = TextEditingController();

    categoriaMovimentoId = 1;
    cartaoId = getCards().first.id;
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

  List<Categoria> getCategories() {
    return movimentoType == 1 ? getEntradaCategories() : getSaidasCategories();
  }

  List<Categoria> getEntradaCategories() {
    return setupConfiguration.categoriasEntradas;
  }

  List<Categoria> getSaidasCategories() {
    return setupConfiguration.categoriasSaidas;
  }

  List<Conta> getCards() {
    return setupConfiguration.contas;
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
          title: 'Erro',
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
          title: 'Erro',
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
      cartaoId: cartaoId,
      tipoMovimentoId: movimentoType,
      categoriaMovimentoId: categoriaMovimentoId,
      obsMovimento: obsMovimento,
      confirmado: confirmado.value,
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
      salvo = true;
    } else {
      if (result is Left &&
          result.swap().getOrElse(() => HttpException('message'))
              is SaldoInsuficiente) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Saldo insuficiente',
            message:
                'O saldo do cartão é insuficiente para realizar o movimento',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            isDismissible: true,
          ),
        );
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

  void switchTransactionType() {
    movimentoType = movimentoType == 1 ? 2 : 1;
    update([
      'category',
      'geral',
    ]);
  }

  Future<Categoria?> getCategoriaSelecionada() async {
    var result = await categoriaService.getCategoria(categoriaMovimentoId);

    if (result is Right) {
      return result.getOrElse(() => Categoria.fake());
    } else {
      return null;
    }
  }

  void selectCategory(BuildContext context) async {
    var categoria = await BottomCategoryComponent.openModalBottomSheet(
      context,
      movimentoType == 1 ? TipoCategoria.entrada : TipoCategoria.saida,
      categoriaMovimentoId,
    );

    if (categoria != null) {
      categoriaMovimentoId = categoria.id;
    } else {
      categoriaMovimentoId = 1;
    }

    update(['category']);
  }
}
