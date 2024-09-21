import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/categoria_bottom_components/bottom_category_component.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/select_categoria_cubit.dart';

class CategoryListItemComponent extends StatefulWidget {
  const CategoryListItemComponent({super.key});

  @override
  State<CategoryListItemComponent> createState() =>
      _CategoryListItemComponentState();
}

class _CategoryListItemComponentState extends State<CategoryListItemComponent> {
  @override
  void initState() {
    var isEntrada =
        context.read<SwitchTransacaoCubit>().state is SwitchTransacaoEntrada;
    context.read<SelectCategoriaCubit>().selectDefaultCategoria(isEntrada);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwitchTransacaoCubit, SwitchTransacaoState>(
      listener: (context, state) {
        var isEntrada = state is SwitchTransacaoEntrada;
        context.read<SelectCategoriaCubit>().selectDefaultCategoria(isEntrada);
      },
      builder: (_, switchState) {
        return BlocBuilder<SelectCategoriaCubit, SelectCategoriaState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            var isEntrada = switchState is SwitchTransacaoEntrada;

            if (state is SelectCategoriaLoading) {
              return const Center(
                child: SizedBox.square(
                  dimension: 25,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is SelectCategoriaError) {
              return const Text('Ocorreu um erro');
            }

            if (state is SelectCategoriaChanged) {
              return _CategoriaItemWidget(
                isEntrada: isEntrada,
                categoria: state.categoria,
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _CategoriaItemWidget extends StatelessWidget {
  const _CategoriaItemWidget({
    required this.categoria,
    required this.isEntrada,
  });

  final bool isEntrada;
  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomCategoryComponent.openModalBottomSheet(
          context,
          isEntrada ? TipoCategoria.entrada : TipoCategoria.saida,
          categoria.id,
        );
      },
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categoria',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                categoria.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
