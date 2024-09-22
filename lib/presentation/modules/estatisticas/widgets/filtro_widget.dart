import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/filtro_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

enum FiltroSelectedType {
  semana(0, 'Semana'),
  mes(1, 'Mês'),
  semestre(2, 'Semestre'),
  ano(3, 'Ano');

  final int id;
  final String nome;

  const FiltroSelectedType(this.id, this.nome);
}

class FiltrosWidget extends StatelessWidget {
  const FiltrosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtrar por',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const GutterSmall(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...FiltroSelectedType.values.map((f) => _FiltroItem(filtro: f)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FiltroItem extends StatelessWidget {
  const _FiltroItem({
    required this.filtro,
  });

  final FiltroSelectedType filtro;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltroCubit, FiltroState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: FilterChip(
            selected: state.filtro == filtro,
            label: Text(filtro.nome),
            onSelected: (value) {
              context.read<FiltroCubit>().changeFiltro(filtro);
            },
          ),
        );
      },
    );
  }
}
