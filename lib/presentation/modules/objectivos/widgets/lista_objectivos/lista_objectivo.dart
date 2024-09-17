import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/presentation/modules/objectivos/widgets/lista_objectivos/lista_objectivo_item.dart';
import 'package:flutter/material.dart';

class ListaObjectivos extends StatelessWidget {
  const ListaObjectivos({super.key});

  @override
  Widget build(BuildContext context) {
    final objectivos = List.generate(20, (index) => Objectivo.fake());

    return Column(
      children: [
        ...objectivos.map((obj) => ListaObjectivoItem(objectivo: obj)),
      ],
    );
  }
}
