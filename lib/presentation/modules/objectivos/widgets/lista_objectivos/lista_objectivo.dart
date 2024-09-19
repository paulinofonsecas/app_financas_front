import 'package:app_financas/presentation/components/empty_widget.dart';
import 'package:app_financas/presentation/modules/objectivos/cubit/listar_objetivos_cubit.dart';
import 'package:app_financas/presentation/modules/objectivos/widgets/lista_objectivos/lista_objectivo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class ListaObjectivos extends StatelessWidget {
  const ListaObjectivos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListarObjetivosCubit, ListarObjetivosState>(
      bloc: context.read<ListarObjetivosCubit>()..loadData(),
      builder: (context, state) {
        if (state is ListarObjetivosLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ListarObjetivosError) {
          return Center(
            child: Text('Ocorreu um erro inesperado: ${state.message}'),
          );
        }

        if (state is ListarObjetivosEmpty) {
          return const Center(
            child: EmptyWidget(
              title: 'Os seus objectivos serão exibidos aqui.',
            ),
          );
        }

        if (state is ListarObjetivosLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ...state.objectivos
                    .map((obj) => ListaObjectivoItem(objectivo: obj)),
                const GutterLarge(),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
