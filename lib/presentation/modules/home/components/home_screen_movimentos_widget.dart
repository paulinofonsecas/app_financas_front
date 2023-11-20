import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/modules/home/abbas/movimentos.dart';
import 'package:app_financas/presentation/modules/movimentos/movimentos_screen.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreenMovimentosWidget extends StatelessWidget {
  const HomeScreenMovimentosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding * 2),
          BlocBuilder<MovimentoBloc, MovimentoState>(
            bloc: context.read<MovimentoBloc>()
              ..add(MovimentoGetMovimentosListOfDayEvent()),
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is MovimentoGetMovimentosListOfDayLoading) {
                return const CircularProgressIndicator();
              }

              if (state is MovimentoGetMovimentosListOfDayLoadingError) {
                return const Text('Ocorreu um erro ao buscar os movimentos');
              }

              if (state is MovimentoGetMovimentosListOfDayEmpty) {
                return const Text('Sem movimentos para apresentar');
              }

              if (state is MovimentoGetMovimentosListOfDaySucess) {
                return MovimentosAtHomePage(
                  movimentos: state.movimentos,
                  verMaisAction: () {
                    Get.to(const MovimentosScreen());
                  },
                );
              }

              return const Text('Estado desconhecido');
            },
          ),
        ],
      ),
    );
  }
}
