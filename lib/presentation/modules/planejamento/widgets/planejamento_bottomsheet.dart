import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/planejamento/cubit/planejamento_atual_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class PlanejamentoBottomsheet extends StatelessWidget {
  const PlanejamentoBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            iconColor: Colors.grey,
            title: Text(
              'Editar planejamento',
            ),
            leading: Icon(Icons.edit),
            // onTap: () {
            //   Navigator.pop(context);
            // },
          ),
          ListTile(
            iconColor: Theme.of(context).colorScheme.error,
            title: const Text(
              'Deletar planejamento',
            ),
            leading: const Icon(Icons.delete),
            onTap: () {
              final cubit = getIt<PlanejamentoAtualCubit>();
              final isSuccess = cubit.state is PlanejamentoAtualSuccess;

              if (isSuccess) {
                cubit
                    .deletePlanejamento(
                        (cubit.state as PlanejamentoAtualSuccess)
                            .planejamento
                            .id)
                    .then((value) {
                  Navigator.pop(context);
                });
              }
            },
          ),
          const Gutter(),
        ],
      ),
    );
  }
}
