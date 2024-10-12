import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/create_objectivo/view/pre_create_objectivo.dart';
import 'package:app_financas/presentation/modules/objectivos/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/objectivos/cubit/listar_objetivos_cubit.dart';
import 'package:app_financas/presentation/modules/objectivos/widgets/objectivos_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template objectivos_page}
/// A description for ObjectivosPage
/// {@endtemplate}
class ObjectivosPage extends StatelessWidget {
  /// {@macro objectivos_page}
  const ObjectivosPage({super.key});

  /// The static route for ObjectivosPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ObjectivosPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ObjectivosBloc(),
        ),
        BlocProvider(
          create: (context) => ListarObjetivosCubit(getIt()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Objectivos'),
            centerTitle: true,
            actions: [
              TextButton.icon(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (_) => BlocProvider.value(
                      value: context.read<ListarObjetivosCubit>(),
                      child: const PreCreateObjectivo(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                iconAlignment: IconAlignment.end,
                label: const Text('Novo'),
              ),
              const GutterSmall(),
            ],
          ),
          body: const ObjectivosView(),
        );
      }),
    );
  }
}

/// {@template objectivos_view}
/// Displays the Body of ObjectivosView
/// {@endtemplate}
class ObjectivosView extends StatelessWidget {
  /// {@macro objectivos_view}
  const ObjectivosView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ObjectivosBody();
  }
}
