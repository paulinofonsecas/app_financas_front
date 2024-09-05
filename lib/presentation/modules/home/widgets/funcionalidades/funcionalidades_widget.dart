import 'package:app_financas/presentation/modules/home/widgets/funcionalidades/funcionalidade_item.dart';
import 'package:flutter/material.dart';

class FuncionalidadesWidget extends StatelessWidget {
  const FuncionalidadesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomContainerButton(
            icon: Icons.add,
            label: 'Adicionar',
            onTap: () {},
          ),
          CustomContainerButton(
            icon: Icons.auto_graph,
            label: 'Lançamentos',
            onTap: () {},
          ),
          CustomContainerButton(
            icon: Icons.track_changes,
            label: 'Objectivos',
            onTap: () {},
          ),
          CustomContainerButton(
            icon: Icons.monetization_on_outlined,
            label: 'Planejamento',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
