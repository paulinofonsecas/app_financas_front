import 'package:app_financas/presentation/modules/objectivos/bloc/bloc.dart';
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
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Objectivos'),
          centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () {
                // Navigator.push(context, CreateObjectivoPage.route());
              },
              icon: const Icon(Icons.add),
              iconAlignment: IconAlignment.end,
              label: const Text('Novo'),
            ),
            const GutterSmall(),
          ],
        ),
        body: const ObjectivosView(),
      ),
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
