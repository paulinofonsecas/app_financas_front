// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/score/domain/services/i_categoria_service.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class BottomCategoryArchivedController extends GetxController {
  late final ICategoriaService categoriaService;
  late TipoCategoria tipoCategoria;

  BottomCategoryArchivedController({
    required this.tipoCategoria,
  });

  @override
  void onInit() {
    categoriaService = getIt();

    super.onInit();
  }

  Future<List<Categoria>> getCategorias() async {
    if (tipoCategoria == TipoCategoria.entrada) {
      return listCategoriasEntradas();
    } else {
      return listCategoriasSaidas();
    }
  }

  Future<List<Categoria>> listCategoriasEntradas() async {
    var result = await categoriaService.listArchivedCategoriasEntradas();

    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      showErrorMessage('Erro', 'Erro ao buscar categorias');
      return [];
    }
  }

  Future<List<Categoria>> listCategoriasSaidas() async {
    var result = await categoriaService.listArchivedCategoriasSaidas();

    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      showErrorMessage('Erro', 'Erro ao buscar categorias');
      return [];
    }
  }

  Future<void> desarquivarCategoria(int categoriaId) async {
    late Either<Failure, bool> result;
    if (tipoCategoria == TipoCategoria.entrada) {
      result = await categoriaService.desarquivarCategoriaEntrada(categoriaId);
    } else {
      result = await categoriaService.desarquivarCategoriaSaida(categoriaId);
    }

    if (result is Right) {
      update(['geral', 'categoriaList']);
      showSucessMessage('Sucesso', 'Categoria desarquivada com sucesso');
    } else {
      showErrorMessage('Erro', 'Erro ao desarquivar categoria');
    }
  }

  void changeTipoCategoria(TipoCategoria tipoCategoria) {
    this.tipoCategoria = tipoCategoria;
    update(['geral', 'switch_categoria_actions']);
  }
}
