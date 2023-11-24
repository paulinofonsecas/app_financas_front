import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';

/// {@template conta_body}
/// Body of the ContaPage.
///
/// Add what it does
/// {@endtemplate}
class ContaBody extends StatelessWidget {
  /// {@macro conta_body}
  const ContaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContaBloc, ContaState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
