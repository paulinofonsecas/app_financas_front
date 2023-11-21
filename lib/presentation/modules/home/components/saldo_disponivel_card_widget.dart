import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/home/components/card_widget.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaldoDisponivelCardWidget extends StatefulWidget {
  const SaldoDisponivelCardWidget({super.key});

  @override
  State<SaldoDisponivelCardWidget> createState() =>
      _SaldoDisponivelCardWidgetState();
}

class _SaldoDisponivelCardWidgetState extends State<SaldoDisponivelCardWidget> {
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
      child: BlocBuilder<HomePageCubit, HomePageState>(
        bloc: homePageCubit..getSaldoTotal(),
        buildWhen: (previous, current) {
          return previous != current && current is HomePageSaldoDisponivelState;
        },
        builder: (context, state) {
          if (state is HomePageSaldoDisponivelLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomePageSaldoDisponivelError) {
            return const Center(child: Text('Erro ao buscar contas'));
          }

          if (state is HomePageSaldoDisponivelEmpty) {
            return const Center(
              child: Text('Nenhum cartão cadastrado'),
            );
          }

          if (state is HomePageSaldoDisponivelSuccess) {
            return LayoutBuilder(
              builder: (c, constraines) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: SaldoDisponivelCard(
                    height: 176,
                    width: size.width * 0.85,
                    saldo: state.saldo,
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
