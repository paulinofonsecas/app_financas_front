import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/planejamento/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/planejamento/cubit/planejamento_atual_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/planejamento_body.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/planejamento_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlanejamentoBloc(),
        ),
        BlocProvider(
          create: (context) => PlanejamentoAtualCubit(getIt()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Planejamento'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) => const PlanejamentoBottomsheet(),
                );
              },
              icon: const Icon(Icons.more_horiz),
            ),
            const Gutter(),
          ],
        ),
        body: const SafeArea(
          bottom: false,
          child: PlanejamentoView(),
        ),
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
