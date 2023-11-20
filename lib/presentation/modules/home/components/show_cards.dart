import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/home/components/card_widget.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowCards extends StatefulWidget {
  const ShowCards({super.key});

  @override
  State<ShowCards> createState() => _ShowCardsState();
}

class _ShowCardsState extends State<ShowCards> {
  late final HomePageCubit homePageCubit;

  @override
  void initState() {
    homePageCubit = locator();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * 0.23,
      child: BlocBuilder<HomePageCubit, HomePageState>(
        bloc: homePageCubit..getContas(),
        buildWhen: (previous, current) {
          return previous != current && current is HomePageListarContasState;
        },
        builder: (context, state) {
          if (state is HomePageListarContasLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomePageListarContasError) {
            return const Center(child: Text('Erro ao buscar contas'));
          }

          if (state is HomePageListarContasEmpty) {
            return const Center(
              child: Text('Nenhum cartão cadastrado'),
            );
          }

          if (state is HomePageListarContasSuccess) {
            return LayoutBuilder(
              builder: (c, constraines) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: CardWidget(
                    height: 176,
                    width: size.width * 0.85,
                    contas: state.contas,
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
