import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CriarCategoriaController extends GetxController {
  late final ICategoriaService categoriaService;
  final nameTextController = TextEditingController();

  var colors = <Color>[
    Colors.blue,
    Colors.purple,
    Colors.green,
  ];
  var icons = <IconData>[
    Icons.place,
    Icons.home,
    Icons.earbuds,
  ];

  int selectedColorIndex = 0;
  int selectedIconIndex = 0;

  TipoCategoria tipoCategoria;

  CriarCategoriaController({
    required this.tipoCategoria,
  });

  @override
  void onInit() {
    categoriaService = getIt();
    super.onInit();
  }

  Color get selectedColor {
    return colors[selectedColorIndex];
  }

  IconData get selectedIcon {
    return icons[selectedIconIndex];
  }

  void setSelectedColorIndex(int index) {
    selectedColorIndex = index;
    update(['color', 'icon']);
  }

  void changeColorFromPicker(Color c) {
    colors[0] = c;
    selectedColorIndex = 0;
    update(['color', 'icon']);
  }

  void setSelectedIconIndex(int index) {
    selectedIconIndex = index;
    update(['icon']);
  }

  void changeIconFromPicker(IconData c) {
    icons[0] = c;
    update(['icon']);
  }

  Future<void> cadastrarCategoria() async {
    var nome = nameTextController.text;
    var color = selectedColor;
    var icon = selectedIcon;

    if (nome.isEmpty) {
      showErrorMessage('Erro', 'Preencha o campo nome');
    }

    var categoria = Categoria.make(
      name: nome,
      color: color,
      icon: icon,
    );
    late Either<Exception, bool> result;

    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.saveEntradaCategoria(categoria);
    } else {
      result = await categoriaService.saveSaidaCategoria(categoria);
    }

    if (result is Left) {
      showErrorMessage('Erro', 'Erro ao criar categoria');
    }
  }

  void changeTipoCategoria(TipoCategoria tipoCategoria) {
    this.tipoCategoria = tipoCategoria;
  }
}
