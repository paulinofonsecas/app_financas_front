import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/modules/create_planejamento/create_planejamento.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/search_list_categorias_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        BlocBuilder<SearchListCategoriasCubit, SearchListCategoriasState>(
          bloc: context.read<SearchListCategoriasCubit>(),
          builder: (context, state) {
            if (state is SearchListCategoriasLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SearchListCategoriasLoaded) {
              return Column(
                  children: state.categorias.map((categoria) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        _onItemTap(categoria);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 4,
                      ),
                      title: Text(
                        categoria.name.capitalize.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: categoria.color ??
                            Theme.of(context).colorScheme.primary,
                        child: Icon(
                          categoria.icon ?? Icons.icecream,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      trailing: Checkbox(
                        value: selectedCategorias
                                .map((e) => e.id)
                                .contains(categoria.id) ||
                            selectedCategorias.map((e) => e.id).any((s) =>
                                categoria.subCategorias
                                    .map((e) => e.id)
                                    .contains(s)),
                        onChanged: (c) {
                          controller.clear();
                          _onItemTap(categoria);
                        },
                        shape: const CircleBorder(),
                      ),
                    ),
                    if (categoria.subCategorias.isNotEmpty) ...[
                      ...(categoria.subCategorias
                            ..sort((a, b) => a.name.compareTo(b.name)))
                          .map((e) => _SubCategoriaItem(
                                categoriaMae: categoria,
                                categoria: e,
                                isSelected: selectedCategorias
                                    .map((e) => e.id)
                                    .contains(e.id),
                                onSubCategoriaTap: () {
                                  controller.clear();
                                  _onItemTap(e.copyWith(icon: categoria.icon));
                                },
                              )),
                      const Gutter(),
                    ],
                  ],
                );
              }).toList());
            }

            return const SizedBox();
          },
        ),
        const Gutter(),
      ],
    );
  }
}

class _SubCategoriaItem extends StatelessWidget {
  const _SubCategoriaItem({
    required this.onSubCategoriaTap,
    required this.categoriaMae,
    required this.categoria,
    required this.isSelected,
  });

  final Categoria categoriaMae;
  final Categoria categoria;
  final GestureTapCallback? onSubCategoriaTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSubCategoriaTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        child: Row(
          children: [
            const GutterLarge(),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: categoria.color,
              ),
            ),
            const Gutter(),
            Text(
              categoria.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Checkbox(
              value: isSelected,
              onChanged: (v) {
                onSubCategoriaTap?.call();
              },
              shape: const CircleBorder(),
            ),
            const Gutter(),
          ],
        ),
      ),
    );
  }
}
