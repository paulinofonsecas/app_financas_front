// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/listar_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import '../search_component.dart';
import 'components/bottom_category_comp_controller.dart';
import 'components/categoria_list_component.dart';

class BottomCategoryComponent extends StatefulWidget {
  const BottomCategoryComponent({
    super.key,
    required this.tipoCategoria,
    required this.selectedCategoriaId,
  });

  final TipoCategoria tipoCategoria;
  final int? selectedCategoriaId;

  static Future<dynamic> openModalBottomSheet(
    BuildContext context,
    TipoCategoria tipoCategoria,
    int? selectedCategoriaId,
  ) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: true,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<SelectCategoriaCubit>(context),
          child: BottomCategoryComponent(
            tipoCategoria: tipoCategoria,
            selectedCategoriaId: selectedCategoriaId,
          ),
        );
      },
    );
  }

  @override
  State<BottomCategoryComponent> createState() =>
      _BottomCategoryComponentState();
}

class _BottomCategoryComponentState extends State<BottomCategoryComponent> {
  late final BottomCategoryCompController controller;
  var _searchedValue = '';

  @override
  void initState() {
    controller = Get.put(
      BottomCategoryCompController(tipoCategoria: widget.tipoCategoria),
    );

    controller.searchTextController.addListener(() {
      setState(() {
        _searchedValue = controller.searchTextController.text;
      });
    });

    super.initState();
  }

  List<Categoria> _getCategorias(
    List<Categoria> categorias,
  ) {
    return categorias
        .where((cat) =>
            cat.name.toLowerCase().contains(_searchedValue.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    controller.changeTipoCategoria(widget.tipoCategoria);

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: SearchComponent(
              textController: controller.searchTextController,
              onClearTap: () {
                controller.searchTextController.clear();
              },
            ),
          ),
          Gutter(),
          Expanded(
            child: BlocBuilder<ListarCategoriaCubit, ListarCategoriaState>(
              bloc: context.read<ListarCategoriaCubit>()
                ..listarCategorias(widget.tipoCategoria),
              builder: (context, state) {
                if (state is ListarCategoriasError) {
                  return Center(
                    child: Text('Ocorreu um erro ao buscar as categorias'),
                  );
                }

                if (state is ListarCategoriasLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ListarCategoriasSuccess) {
                  return CategoriaListComponent(
                    categorias: _getCategorias(state.categorias),
                    selectedCategoriaId: widget.selectedCategoriaId,
                    tipoCategoria: widget.tipoCategoria,
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
