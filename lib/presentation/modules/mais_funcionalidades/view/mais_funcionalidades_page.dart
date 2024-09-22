import 'package:app_financas/presentation/modules/mais_funcionalidades/cubit/cubit.dart';
import 'package:app_financas/presentation/modules/mais_funcionalidades/widgets/mais_funcionalidades_body.dart';
import 'package:flutter/material.dart';

/// {@template mais_funcionalidades_page}
/// A description for MaisFuncionalidadesPage
/// {@endtemplate}
class MaisFuncionalidadesPage extends StatelessWidget {
  /// {@macro mais_funcionalidades_page}
  const MaisFuncionalidadesPage({super.key});

  /// The static route for MaisFuncionalidadesPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const MaisFuncionalidadesPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MaisFuncionalidadesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mais Funcionalidades'),
        ),
        body: const MaisFuncionalidadesView(),
      ),
    );
  }
}

/// {@template mais_funcionalidades_view}
/// Displays the Body of MaisFuncionalidadesView
/// {@endtemplate}
class MaisFuncionalidadesView extends StatelessWidget {
  /// {@macro mais_funcionalidades_view}
  const MaisFuncionalidadesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaisFuncionalidadesBody();
  }
}
