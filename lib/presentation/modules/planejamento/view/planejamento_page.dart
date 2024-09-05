import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/planejamento/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/planejamento_body.dart';

/// {@template planejamento_page}
/// A description for PlanejamentoPage
/// {@endtemplate}
class PlanejamentoPage extends StatelessWidget {
  /// {@macro planejamento_page}
  const PlanejamentoPage({super.key});

  /// The static route for PlanejamentoPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PlanejamentoPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanejamentoBloc(),
      child: const Scaffold(
        body: PlanejamentoView(),
      ),
    );
  }    
}

/// {@template planejamento_view}
/// Displays the Body of PlanejamentoView
/// {@endtemplate}
class PlanejamentoView extends StatelessWidget {
  /// {@macro planejamento_view}
  const PlanejamentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlanejamentoBody();
  }
}
