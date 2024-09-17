import 'package:app_financas/presentation/modules/objectivos/widgets/lista_objectivos/lista_objectivo.dart';
import 'package:flutter/material.dart';

/// {@template objectivos_body}
/// Body of the ObjectivosPage.
///
/// Add what it does
/// {@endtemplate}
class ObjectivosBody extends StatelessWidget {
  /// {@macro objectivos_body}
  const ObjectivosBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ListaObjectivos(),
        ],
      ),
    );
  }
}
