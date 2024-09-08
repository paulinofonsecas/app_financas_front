import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/create_planejamento/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_stepper_controll_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/search_list_categorias_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/create_planejamento_body.dart';
import 'package:flutter/material.dart';

/// {@template create_planejamento_page}
/// A description for CreatePlanejamentoPage
/// {@endtemplate}
class CreatePlanejamentoPage extends StatelessWidget {
  /// {@macro create_planejamento_page}
  const CreatePlanejamentoPage({super.key});

  /// The static route for CreatePlanejamentoPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const CreatePlanejamentoPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreatePlanejamentoBloc(getIt()),
        ),
        BlocProvider(
          create: (context) => CreatePlanejamentoStepperControllCubit(),
        ),
        BlocProvider(
          create: (context) => SearchListCategoriasCubit(),
        ),
        BlocProvider(
          create: (context) => CreatePlanejamentoCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo planejamento'),
          centerTitle: true,
          elevation: 0,
        ),
        body: const CreatePlanejamentoView(),
      ),
    );
  }
}

/// {@template create_planejamento_view}
/// Displays the Body of CreatePlanejamentoView
/// {@endtemplate}
class CreatePlanejamentoView extends StatelessWidget {
  /// {@macro create_planejamento_view}
  const CreatePlanejamentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreatePlanejamentoBody();
  }
}
