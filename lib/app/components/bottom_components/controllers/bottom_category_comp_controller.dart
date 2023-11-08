// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/helders/helpers.dart';

class BottomCategoryCompController extends GetxController {
  late final TextEditingController searchTextController;
  late final ICategoriaService service;
  TipoCategoria tipoCategoria;

  BottomCategoryCompController({
    required this.tipoCategoria,
  });

  @override
  void onInit() {
    service = Get.find();
    searchTextController = TextEditingController();

    searchTextController.addListener(() {
      update(['categoriaList']);
    });

    super.onInit();
  }

  Future<List<Categoria>> listCategoriasEntradas() async {
    var result = await service.listCategoriasEntradas();

    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      showErrorMessage('Erro', 'Erro ao buscar categorias');
      return [];
    }
  }

  Future<List<Categoria>> listCategoriasSaidas() async {
    var result = await service.listCategoriasSaidas();

    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      showErrorMessage('Erro', 'Erro ao buscar categorias');
      return [];
    }
  }

  Future<List<Categoria>> getCategorias() async {
    var list = <Categoria>[];

    if (tipoCategoria == TipoCategoria.entrada) {
      list = await listCategoriasEntradas();
    } else {
      list = await listCategoriasSaidas();
    }

    if (searchTextController.text.isNotEmpty) {
      list = filterBySearchArg(list);
    }

    return list;
  }

  List<Categoria> filterBySearchArg(List<Categoria> list) {
    var arg = searchTextController.text;

    list = list.where((element) {
      return element.name.toLowerCase().contains(arg.toLowerCase());
    }).toList();

    return list;
  }
}
