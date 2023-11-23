// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore: unused_import
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';

import '../controllers/home_page_controller.dart';

class SaldoDisponivelCard extends StatelessWidget {
  const SaldoDisponivelCard({
    Key? key,
    required this.width,
    required this.height,
    required this.saldo,
  }) : super(key: key);

  final double width;
  final double height;
  final double saldo;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomePageController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.onInverseSurface,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding * 1.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Saldo disponivel em contas",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                ),
              ),
              GutterLarge(),
              BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
                builder: (context, state) {
                  return Text(
                    state.value ? numberFormat.format(saldo) : '**********',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              GutterTiny(),
              IconButton(
                onPressed: () {
                  context.read<ShowMoneyCubit>().changeValue();
                },
                icon: BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
                  builder: (context, state) {
                    return Icon(
                      state.value
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: Colors.grey,
                      size: 32,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.onInverseSurface,
    );
  }
}
