import 'package:app_financas/presentation/modules/home/abbas/movimentos_at_home_page.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/last_movimentos_cubit.dart';
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
          BlocBuilder<LastMovimentosCubit, LastMovimentosState>(
            bloc: context.read<LastMovimentosCubit>()..getLastMovimentos(),
            builder: (context, state) {
              if (state is LastMovimentosLoading ||
                  state is LastMovimentosInitialState) {
                return const CircularProgressIndicator();
              }

              if (state is LastMovimentosError) {
                return const Text('Ocorreu um erro ao buscar os movimentos');
              }

              if (state is LastMovimentosEmpty) {
                return const Text('Sem movimentos para apresentar');
              }

              if (state is LastMovimentosSuccess) {
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
