import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaldoVisibility extends StatelessWidget {
  const SaldoVisibility({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ShowMoneyCubit>().changeValue();
      },
      icon: BlocBuilder<ShowMoneyCubit, ShowMoneyState>(
        builder: (context, state) {
          return Icon(
            state.value ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            color: Colors.grey,
            size: 18,
          );
        },
      ),
    );
  }
}
