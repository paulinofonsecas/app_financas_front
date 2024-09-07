import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/categoria_bottom_components/components/categoria_item_component.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/search_list_categorias_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CategoriasStep extends StatelessWidget {
  const CategoriasStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalSearchCategoriaBody();
  }
}

class GlobalSearchCategoriaBody extends StatefulWidget {
  const GlobalSearchCategoriaBody({super.key});

  @override
  State<GlobalSearchCategoriaBody> createState() =>
      _GlobalSearchCategoriaBodyState();
}

class _GlobalSearchCategoriaBodyState extends State<GlobalSearchCategoriaBody> {
  final controller = TextEditingController();
  final selectedCategorias = <int>[];

  @override
  void initState() {
    context.read<SearchListCategoriasCubit>().loadCategoriaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchListCategoriasCubit, SearchListCategoriasState>(
      bloc: context.read<SearchListCategoriasCubit>(),
      builder: (context, state) {
        if (state is SearchListCategoriasLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SearchListCategoriasError) {
          return const Center(
            child: Text('Ups, algo deu errado'),
          );
        }

        if (state is SearchListCategoriasLoaded) {
          return SearchableList<Categoria>(
            searchTextController: controller,
            initialList: state.categorias,
            itemBuilder: (Categoria categoria) => CategoriaItem(
              onTap: () {
                controller.clear();
                setState(() {
                  if (selectedCategorias.contains(categoria.id)) {
                    selectedCategorias.remove(categoria.id);
                  } else {
                    selectedCategorias.add(categoria.id);
                  }
                });
              },
              categoria: categoria,
              isSelected: selectedCategorias.contains(categoria.id),
            ),
            filter: (String value) => state.categorias
                .where(
                  (element) =>
                      element.name.toLowerCase().contains(value.toLowerCase()),
                )
                .toList(),
            emptyWidget: const Center(
              child: Text('Nenhuma categoria encontrada'),
            ),
            inputDecoration: const InputDecoration(
              hintText: 'Pesquisar categorias',
              fillColor: Colors.white,
            ),
          );
        }

        return const Placeholder();
      },
    );
  }
}
