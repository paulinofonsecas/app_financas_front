// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_list_header_cubit.dart';

import '../cubit/conta_periodo_picker_cubit_cubit.dart';

class ContaListHeaderWidget extends StatelessWidget {
  const ContaListHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ContaListHeaderCubit>().loadData(DateTime.now().month);

    return BlocConsumer<ContaPeriodoPickerCubit, ContaPeriodoPickerState>(
      listener: (context, state) {
        if (state is ContaPeriodoPickerChanged) {
          context.read<ContaListHeaderCubit>().loadData(state.mes);
        }
      },
      buildWhen: (oldState, newState) => oldState.mes != newState.mes,
      builder: (context, state) {
        return _ContaListHeaderView(
          mes: state.mes,
        );
      },
    );
  }
}

class _ContaListHeaderView extends StatelessWidget {
  const _ContaListHeaderView({
    Key? key,
    required this.mes,
  }) : super(key: key);

  final int mes;

  @override
  Widget build(BuildContext context) {
    var balancoState = context.watch<ContaListHeaderCubit>().state;
    var now = DateTime.now();
    var ultimoDiaDoMes = lastDayOfWeek(now.year, mes);

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kDefaultPadding / 4,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _HeaderItemWidget(
              icon: FontAwesomeIcons.coins,
              title: 'Total',
              value: (balancoState is ContaListHeaderSuccess)
                  ? balancoState.balanco.saldo
                  : 0,
            ),
          ),
          Expanded(
            child: _HeaderItemWidget(
              icon: FontAwesomeIcons.dollarSign,
              title: 'Total até $ultimoDiaDoMes/${getSortMonthName(mes)}',
              value: (balancoState is ContaListHeaderSuccess)
                  ? balancoState.balanco.saldoPrevisto
                  : 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderItemWidget extends StatelessWidget {
  const _HeaderItemWidget({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[800], size: 18),
        const GutterSmall(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              numberFormat.format(value),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kVerdeForteColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
