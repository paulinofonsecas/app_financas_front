// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/item_planejamento.dart';
import 'package:app_financas/core/domain/entitys/planejamento.dart';
import 'package:app_financas/presentation/components/duet_info.dart';
import 'package:app_financas/presentation/modules/create_planejamento/bloc/create_planejamento_bloc.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/finish_step/item_planejado_pie_chart.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/finish_step/success_create_planejamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class FinishStep extends StatelessWidget {
  const FinishStep({super.key});

  @override
  Widget build(BuildContext context) {
    final planejamento =
        context.watch<CreatePlanejamentoCubit>().state.planejamento;
    final valorTotal = planejamento.plafound;
    final somaDistribuicao = planejamento.itens
        .map((e) => e.plafound)
        .fold(0.0, (previousValue, element) => previousValue + element);

    return BlocBuilder<CreatePlanejamentoBloc, CreateNewPlanejamentoState>(
      builder: (context, state) {
        if (state is CreateNewPlanejamentoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CreateNewPlanejamentoSuccess) {
          return SuccessCreatePlanejamento(
            planejamento: state.planejamento,
          );
        }

        return _ResumoPlanejamento(
          valorTotal: valorTotal,
          planejamento: planejamento,
          somaDistribuicao: somaDistribuicao,
        );
      },
    );
  }
}

class _ResumoPlanejamento extends StatelessWidget {
  const _ResumoPlanejamento({
    required this.valorTotal,
    required this.planejamento,
    required this.somaDistribuicao,
  });

  final double valorTotal;
  final Planejamento planejamento;
  final double somaDistribuicao;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            'Resumo do planejamento',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const Gutter(),
        const Divider(),
        const Gutter(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
          child: Column(
            children: [
              DuetInfo(
                title: 'Receita total',
                valor: valorTotal,
                extended: true,
              ),
              const GutterSmall(),
              DuetInfo(
                title: 'Categorias inclusas',
                valor: planejamento.itens.length.toDouble(),
                extended: true,
                isMoney: false,
              ),
              const GutterSmall(),
              DuetInfo(
                title: 'Não planejado',
                valor: planejamento.plafound - somaDistribuicao,
                extended: true,
              ),
            ],
          ),
        ),
        SizedBox.square(
          dimension: context.width,
          child: ItemPlanejamentoPieChart(
            itemPlanejamentos: [
              ...planejamento.itens,
              ItemPlanejamento(
                id: 80808080,
                categoria: Categoria(id: 80808080, name: 'Não plan.'),
                plafound: planejamento.plafound - somaDistribuicao,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
