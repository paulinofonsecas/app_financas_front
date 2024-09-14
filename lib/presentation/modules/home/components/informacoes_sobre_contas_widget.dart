import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class InformacoesSobreContasWidget extends StatelessWidget {
  const InformacoesSobreContasWidget({super.key, required this.totalContas});

  final int totalContas;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const GutterSmall(),
        Text(
          '$totalContas contas controladas',
        ),
        TextButton(
          onPressed: () {
            context.read<AppBloc>().add(const AppChangeBottomNavIndexEvent(1));
          },
          child: const Text(
            'Listar contas',
          ),
        )
      ],
    );
  }
}
