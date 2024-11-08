import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarCategoriaController extends GetxController {
  late final ICategoriaUseCases categoriaService;
  late final TextEditingController nameTextController;

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
  Categoria categoria;

  EditarCategoriaController({
    required this.tipoCategoria,
    required this.categoria,
  });

  @override
  void onInit() {
    categoriaService = getIt();
    nameTextController = TextEditingController();

    nameTextController.text = categoria.name;
    changeColorFromPicker(categoria.color ?? colors.first);
    changeIconFromPicker(categoria.icon ?? icons.first);

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

  Future<void> editarCategoria() async {
    var nome = nameTextController.text;
    var color = selectedColor;
    var icon = selectedIcon;

    if (nome.isEmpty) {
      showErrorMessage('Erro', 'Preencha o campo nome');
    }

    var categoria0 = Categoria(
      id: categoria.id,
      name: nome,
      color: color,
      icon: icon,
      isArchived: categoria.isArchived,
      subCategoria: categoria.subCategoria,
      subCategorias: categoria.subCategorias,
    );

    late Either<Exception, bool> result;

    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.editEntradaCategoria(categoria0);
    } else {
      result = await categoriaService.editSaidaCategoria(categoria0);
    }

    if (result is Left) {
      showErrorMessage('Erro', 'Erro ao criar categoria');
    }
  }

  void changeTipoCategoria(TipoCategoria tipoCategoria) {
    this.tipoCategoria = tipoCategoria;
  }
}
