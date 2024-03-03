import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/home/abbas/components/abba_header.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/widgets/movimentos_pendentes.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';

class MovimentosPendentesBody extends StatelessWidget {
  const MovimentosPendentesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovimentosPendentesBloc, MovimentosPendentesState>(
      bloc: context.read<MovimentosPendentesBloc>()
        ..add(const LoadMovimentosPendentesEvent()),
      builder: (context, state) {
        if (state is MovimentosPendentesLoading) {
          return const CircularProgressIndicator();
        }

        if (state is MovimentosPendentesError) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is MovimentosPendentesSuccess) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: AbbaHeader(
                  title: 'Movimentos pendentes',
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              SizedBox(
                height: 135,
                child: ListMovimentosPendentes(
                  movimentosPendentes: state.movimentosPendentes,
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
