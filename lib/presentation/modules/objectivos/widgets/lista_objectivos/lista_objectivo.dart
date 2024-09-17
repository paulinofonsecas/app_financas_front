import 'package:app_financas/presentation/modules/objectivos/cubit/listar_objetivos_cubit.dart';
import 'package:app_financas/presentation/modules/objectivos/widgets/lista_objectivos/lista_objectivo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaObjectivos extends StatelessWidget {
  const ListaObjectivos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListarObjetivosCubit, ListarObjetivosState>(
      bloc: context.read<ListarObjetivosCubit>()..loadData(),
      builder: (context, state) {
        if (state is ListarObjetivosLoading) {
          return const SizedBox.square(
            dimension: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ListarObjetivosError) {
          return SizedBox.square(
            dimension: 50,
            child: Center(
              child: Text(state.message),
            ),
          );
        }

        if (state is ListarObjetivosLoaded) {
          return Column(
            children: [
              ...state.objectivos
                  .map((obj) => ListaObjectivoItem(objectivo: obj)),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
