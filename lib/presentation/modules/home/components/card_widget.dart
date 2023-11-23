// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore: unused_import
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/presentation/helders/format_helpers.dart';

import 'entradas_saidas.dart';
import 'omited_text.dart';

class SaldoDisponivelCard extends StatelessWidget {
  const SaldoDisponivelCard({
    Key? key,
    required this.height,
    required this.saldo,
  }) : super(key: key);

  final double height;
  final double saldo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(.1),
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Saldo atual",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
            ),
          ),
          GutterTiny(),
          BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
            builder: (context, state) {
              return state.value
                  ? Text(
                      numberFormat.format(saldo),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : OmitedText();
            },
          ),
          IconButton(
            onPressed: () {
              context.read<ShowMoneyCubit>().changeValue();
            },
            icon: BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
              builder: (context, state) {
                return Icon(
                  state.value ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                  color: Colors.grey,
                  size: 22,
                );
              },
            ),
          ),
          GutterTiny(),
          EntradasESaidas(),
          Gutter(),
        ],
      ),
    );
  }
}

