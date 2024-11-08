import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/planejamento.dart';
import 'package:app_financas/presentation/components/duet_info.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/discribuicao_step/item_distribuicao_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class DistribuicaoStep extends StatelessWidget {
  const DistribuicaoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CreatePlanejamentoCubit>().state.planejamento;
    final somaDistribuicao = model.itens
        .map((e) => e.plafound)
        .fold(0.0, (previousValue, element) => previousValue + element);

    return SingleChildScrollView(
      child: Column(
        children: [
          _InformacoesWidget(model: model, somaDistribuicao: somaDistribuicao),
          const Gutter(),
          const Text(
            'Distribua o valor total entre as categorias:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const GutterLarge(),
          _OtherCategories(model: model, somaDistribuicao: somaDistribuicao),
          const Divider(),
          ...model.itens.map((e) => ItemDistribuicaoWidget(
                itemPlanejamento: e,
                maxValue: model.plafound - somaDistribuicao + e.plafound,
              )),
          const Gutter(),
        ],
      ),
    );
  }
}

class _InformacoesWidget extends StatelessWidget {
  const _InformacoesWidget({
    required this.model,
    required this.somaDistribuicao,
  });

  final Planejamento model;
  final double somaDistribuicao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          DuetInfo(
            title: 'Valor total',
            valor: model.plafound,
            extended: true,
          ),
          DuetInfo(
            title: 'Planificado',
            valor: somaDistribuicao,
            extended: true,
          ),
        ],
      ),
    );
  }
}

class _OtherCategories extends StatelessWidget {
  const _OtherCategories({
    required this.model,
    required this.somaDistribuicao,
  });

  final Planejamento model;
  final double somaDistribuicao;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Não definido',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const Icon(
        Icons.all_inclusive,
      ),
      trailing: Text(
        numberFormat.format(model.plafound - somaDistribuicao),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
