import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class RegistarEntradaController extends GetxController {
  late final TextEditingController descricaoTextController;
  late final TextEditingController dateTextController;
  late final TextEditingController valorTextController;
  late final TextEditingController obsTextController;

  var date = DateTime.now();
  late int categoriaMovimentoId;
  late int cartaoId;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    descricaoTextController = TextEditingController();
    dateTextController = TextEditingController();
    valorTextController = TextEditingController();
    obsTextController = TextEditingController();

    categoriaMovimentoId = getCategories().first.id;
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
    return dateFormat.format(date);
  }

  List<CategoriaMovimento> getCategories() {
    return [
      CategoriaMovimento(
        id: 1,
        name: 'compras',
      ),
      CategoriaMovimento(
        id: 2,
        name: 'casa',
      ),
      CategoriaMovimento(
        id: 3,
        name: 'trabalho',
      ),
      CategoriaMovimento(
        id: 4,
        name: 'cafe',
      ),
    ];
  }

  List<Conta> getCards() {
    return [
      Conta(
        id: 1,
        nome: 'Bai',
        numero: '001',
        saldo: 1000,
        bancoId: 1,
      ),
      Conta(
        id: 2,
        nome: 'Yetu',
        numero: '002',
        saldo: 10000,
        bancoId: 2,
      ),
    ];
  }

  int _getUserId() {
    return 1;
  }

  void finalizarMovimento() {
    var descricaoMovimento = descricaoTextController.text;
    var dateMovimento = date;
    var valorMovimento = double.parse(valorTextController.text);
    var obsMovimento = obsTextController.text;

    var movimento = Movimento.make(
      valor: valorMovimento,
      data: dateMovimento,
      descricao: descricaoMovimento,
      userId: _getUserId(),
      cartaoId: cartaoId,
      tipoMovimentoId: 2,
      categoriaMovimentoId: categoriaMovimentoId,
      obsMovimento: obsMovimento,
    );

    if (kDebugMode) {
      print(movimento);
    }
  }
}
