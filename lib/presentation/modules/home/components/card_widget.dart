// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore: unused_import
import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/home/components/saldo_visibility.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SaldoCardWidget extends StatelessWidget {
  const SaldoCardWidget({
    super.key,
    required this.saldo,
  });

  final double saldo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSaldoVisibility(context),
              GutterSmall(),
              _buildSaldoWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaldoVisibility(BuildContext context) {
    return SaldoVisibility();
  }

  BlocBuilder<ShowMoneyCubit, ShowMoneyState> _buildSaldoWidget() {
    return BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
      builder: (context, state) {
        return Text(
          state.value ? ('Kz **,00') : numberFormat.format(saldo),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
