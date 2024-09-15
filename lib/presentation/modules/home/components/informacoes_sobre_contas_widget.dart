import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformacoesSobreContasWidget extends StatelessWidget {
  const InformacoesSobreContasWidget({super.key, required this.totalContas});

  final int totalContas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$totalContas contas controladas',
          ),
          TextButton(
            onPressed: () {
              context
                  .read<AppBloc>()
                  .add(const AppChangeBottomNavIndexEvent(1));
            },
            child: const Text(
              'Listar contas',
            ),
          )
        ],
      ),
    );
  }
}
