import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/components/empty_widget.dart';
import 'package:app_financas/presentation/modules/home/abbas/movimentos_at_home_page.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/last_movimentos_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/movimentos_screen.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          BlocBuilder<ListMovimentosCubit, LastMovimentosState>(
            bloc: context.read<ListMovimentosCubit>()..getLastMovimentos(),
            builder: (context, state) {
              if (state is LastMovimentosLoading ||
                  state is LastMovimentosInitialState) {
                return const CircularProgressIndicator();
              }

              if (state is LastMovimentosError) {
                return const Text('Ocorreu um erro ao buscar os movimentos');
              }

              if (state is LastMovimentosEmpty) {
                return const EmptyWidget(title: 'Nenhum movimento cadastrado.');
              }

              if (state is LastMovimentosSuccess) {
                return MovimentosAtHomePage(
                  movimentos: state.movimentos,
                  verMaisAction: () {
                    Get.to(MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<HomePageCubit>(),
                        ),
                        BlocProvider.value(
                          value: context.read<ShowMoneyCubit>(),
                        ),
                      ],
                      child: const MovimentosScreen(),
                    ));
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
