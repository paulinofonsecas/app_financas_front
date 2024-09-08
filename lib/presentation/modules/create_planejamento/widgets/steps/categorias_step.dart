import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/categoria_bottom_components/components/categoria_item_component.dart';
import 'package:app_financas/presentation/modules/create_planejamento/create_planejamento.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/search_list_categorias_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
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

  @override
  void initState() {
    context.read<SearchListCategoriasCubit>().loadCategoriaList();
    super.initState();
  }

  void _onItemTap(Categoria categoria) {
    context.read<CreatePlanejamentoCubit>().addOrRemoveCategorias(categoria);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategorias = context
        .watch<CreatePlanejamentoCubit>()
        .state
        .planejamento
        .itens
        .map((e) => e.categoria)
        .toList();

    return Column(
      children: [
        const Text(
          'Selecione as categorias que deseja incluir no planejamento.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gutter(),
        Expanded(
          child:
              BlocBuilder<SearchListCategoriasCubit, SearchListCategoriasState>(
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
                      _onItemTap(categoria);
                    },
                    categoria: categoria,
                    isSelected: selectedCategorias.contains(categoria),
                  ),
                  filter: (String value) => state.categorias
                      .where(
                        (element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()),
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
          ),
        ),
      ],
    );
  }
}
