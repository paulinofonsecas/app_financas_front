import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/planejamento/cubit/periodo_planejamento_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeriodoPlanejamento extends StatelessWidget {
  const PeriodoPlanejamento({super.key});

  String showYear(int year) {
    if (year == DateTime.now().year) {
      return '';
    }

    return ' - ${year.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    final periodoCubit = context.watch<PeriodoPlanejamentoCubit>();

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Row(
        children: [
          const Spacer(flex: 2),
          IconButton(
            onPressed: () {
              periodoCubit.previousMonth();
            },
            icon: const Icon(Icons.chevron_left),
            color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(),
          Text(
            '${getMonthName(periodoCubit.state.periodo.month)} ${showYear(periodoCubit.state.periodo.year)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          IconButton(
            onPressed: periodoCubit.state.periodo.month == DateTime.now().month
                ? null
                : () {
                    periodoCubit.nextMonth();
                  },
            icon: const Icon(Icons.chevron_right),
            color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
