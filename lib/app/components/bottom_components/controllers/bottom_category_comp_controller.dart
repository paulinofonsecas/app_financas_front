// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/helders/helpers.dart';

class BottomCategoryCompController extends GetxController {
  late final ICategoriaService service;
  TipoCategoria tipoCategoria;

  BottomCategoryCompController({
    required this.tipoCategoria,
  });

  @override
  void onInit() {
    service = Get.find();
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

  Future<List<Categoria>> getCategorias() {
    if (tipoCategoria == TipoCategoria.entrada) {
      return listCategoriasEntradas();
    } else {
      return listCategoriasSaidas();
    }
  }
}
