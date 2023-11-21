// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EntradasESaidas extends StatelessWidget {
  const EntradasESaidas({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kBlackColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<HomePageCubit, HomePageState>(
              bloc: context.read<HomePageCubit>()..getSaldoTotalEntradas(),
              buildWhen: (previous, current) {
                return previous != current &&
                    current is HomePageGetEntradasSuccess;
              },
              builder: (context, state) {
                if (state is HomePageGetEntradasSuccess) {
                  return EntradaOuSaidaWidget(
                    asset: 'assets/svgs/home_page/Arrow_down.svg',
                    title: 'Entradas',
                    valor: state.entradas,
                  );
                }

                if (state is HomePageGetEntradasError) {
                  return Center(
                      child: Text(
                    '0.0',
                  ));
                }

                if (state is HomePageGetEntradasLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Center(child: Text('0.0'));
              },
            ),
            VerticalDivider(
              color: Colors.white,
            ),
            BlocBuilder<HomePageCubit, HomePageState>(
              bloc: context.read<HomePageCubit>()..getSaldoTotalSaidas(),
              buildWhen: (previous, current) {
                return previous != current &&
                    current is HomePageGetSaidasSuccess;
              },
              builder: (context, state) {
                if (state is HomePageGetSaidasSuccess) {
                  return EntradaOuSaidaWidget(
                    asset: 'assets/svgs/home_page/Arrow_up.svg',
                    title: 'Saidas',
                    valor: state.saidas,
                  );
                }

                if (state is HomePageGetSaidasError) {
                  return Center(
                      child: Text(
                    '0.0',
                  ));
                }

                if (state is HomePageGetSaidasLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Center(child: Text('0.0'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EntradaOuSaidaWidget extends StatelessWidget {
  const EntradaOuSaidaWidget({
    super.key,
    required this.asset,
    required this.title,
    required this.valor,
  });

  final String asset;
  final String title;
  final double valor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(asset, width: 16),
              SizedBox(width: kDefaultPadding / 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GutterTiny(),
          BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
            builder: (context, state) {
              return Text(
                state.value ? numberFormat.format(valor) : '********',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
