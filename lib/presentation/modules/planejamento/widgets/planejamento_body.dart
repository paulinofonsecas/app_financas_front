import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/planejamento/bloc/bloc.dart';

/// {@template planejamento_body}
/// Body of the PlanejamentoPage.
///
/// Add what it does
/// {@endtemplate}
class PlanejamentoBody extends StatelessWidget {
  /// {@macro planejamento_body}
  const PlanejamentoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanejamentoBloc, PlanejamentoState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
