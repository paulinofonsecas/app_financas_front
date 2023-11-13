import 'package:app_financas/app/components/categoria_bottom_components/bottom_category_component.dart';
import 'package:app_financas/app/modules/home/home_page.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
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
  late final ICategoriaService categoriaService;
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
  late int categoriaSelectedId;
  late int cartaoId;
  var alterandoTransacao = false.obs;
  var salvo = false;

  EditTransacaoController({
    required this.movimentoType,
    required this.movimento,
  });

  @override
  void onInit() {
    movimentoService = Get.find();
    setupConfiguration = Get.find();
    categoriaService = Get.find();

    descricaoTextController = TextEditingController(text: movimento.descricao);
    dateTextController = TextEditingController(text: getSelectedDate());
    valorTextController = TextEditingController(
      text: movimento.valor.toString(),
    );
    obsTextController = TextEditingController(text: movimento.obsMovimento);

    super.onInit();
  }

  void init() {
    categoriaSelectedId = movimento.categoriaMovimentoId;

    descricaoTextController.text = movimento.descricao;
    dateTextController.text = getSelectedDate();
    valorTextController.text = movimento.valor.toString();
    obsTextController.text = movimento.obsMovimento ?? ' ';
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

  List<Categoria> getCategories() {
    return setupConfiguration.categoriasEntradas;
  }

  List<Conta> getCards() {
    return setupConfiguration.contas;
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
      categoriaMovimentoId: categoriaSelectedId,
      obsMovimento: obsMovimento,
      confirmado: confirmado.value,
    );

    var result = await movimentoService.editMovimento(myMovimento);

    if (result is Right && result.getOrElse(() => false)) {
      dynamic result0 = await movimentoService.getMovimento(movimento.id);
      result0 = result0.getOrElse(() => Movimento.fake());
      movimento = result0;
      Get.back(closeOverlays: true, result: movimento);
      resetVariables();
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

  void resetVariables() {
    descricaoTextController.clear();
    dateTextController.clear();
    valorTextController.clear();
    obsTextController.clear();

    alterandoTransacao.value = false;
    salvo = false;
  }

  void switchTransactionType() {
    movimentoType = movimentoType == 1 ? 2 : 1;
    update(['geral', 'category']);
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

  void deleteMovimento() async {
    var result = await movimentoService.deleteMovimento(movimento.id);

    if (result is Right && result.getOrElse(() => false)) {
      Get.off(() => const HomePage());
    } else {
      var error = result.swap().getOrElse(() => HttpException('message'));
      if (kDebugMode) {
        print(error.message);
      }
      showErrorMessage('Erro', 'Erro desconhecido ao deletar a transação');
    }
  }

  void selectCategory(BuildContext context) async {
    var categoria = await BottomCategoryComponent.openModalBottomSheet(
      context,
      movimentoType == 1 ? TipoCategoria.entrada : TipoCategoria.saida,
      categoriaSelectedId,
    );

    if (categoria != null) {
      categoriaSelectedId = categoria.id;
    } else {
      categoriaSelectedId = 1;
    }

    update(['category']);
  }

  Future<Categoria?> getCategoriaSelecionada() async {
    if (movimentoType == 1) {
      return await getCategoriaEntradaSelecionada();
    } else {
      return await getCategoriaSaidaSelecionada();
    }
  }

  Future<Categoria?> getCategoriaEntradaSelecionada() async {
    var result =
        await categoriaService.getEntradaCategoria(categoriaSelectedId);

    if (result is Right) {
      return result.getOrElse(() => Categoria.fake());
    } else {
      return null;
    }
  }

  Future<Categoria?> getCategoriaSaidaSelecionada() async {
    var result = await categoriaService.getSaidaCategoria(categoriaSelectedId);

    if (result is Right) {
      return result.getOrElse(() => Categoria.fake());
    } else {
      return null;
    }
  }
}
