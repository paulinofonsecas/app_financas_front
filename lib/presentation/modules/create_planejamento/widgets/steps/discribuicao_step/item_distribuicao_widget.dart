import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/item_planejamento.dart';
import 'package:app_financas/presentation/components/categorie_avatar.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/discribuicao_step/atribuir_plafound_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDistribuicaoWidget extends StatelessWidget {
  const ItemDistribuicaoWidget(
      {super.key, required this.itemPlanejamento, required this.maxValue});

  final ItemPlanejamento itemPlanejamento;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: ListTile(
        onTap: () async {
          showDialog(
            context: context,
            builder: (_) => AtribuirPlafoundDialog(
              plafound: itemPlanejamento.plafound,
              maxValue: maxValue,
            ),
          ).then((value) {
            if (value != null) {
              context
                  .read<CreatePlanejamentoCubit>()
                  .changeItemPlanejamentoPlafound(
                    itemPlanejamento.copyWith(
                      plafound: value,
                    ),
                  );
            }
          });
        },
        title: Text(
          itemPlanejamento.categoria.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: CategorieAvatar(
          categoria: itemPlanejamento.categoria,
        ),
        trailing: Text(
          numberFormat.format(itemPlanejamento.plafound),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
