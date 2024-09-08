import 'dart:developer';

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/create_planejamento/view/create_planejamento_page.dart';
import 'package:app_financas/presentation/modules/planejamento/cubit/periodo_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/categorias_planejamento_section.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/header_planejamento_section.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/info_planejamento_section.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/periodo_planejamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../cubit/planejamento_atual_cubit.dart';

/// {@template planejamento_body}
/// Body of the PlanejamentoPage.
///
/// Add what it does
/// {@endtemplate}
class PlanejamentoBody extends StatelessWidget {
  /// {@macro planejamento_body}
  const PlanejamentoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeriodoPlanejamentoCubit, PeriodoPlanejamentoState>(
      builder: (context, periodoState) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Column(
              children: [
                const PeriodoPlanejamento(),
                BlocBuilder<PlanejamentoAtualCubit, PlanejamentoAtualState>(
                  bloc: getIt<PlanejamentoAtualCubit>()
                    ..getPlanejamento(periodoState.periodo),
                  builder: (context, state) {
                    if (state is PlanejamentoAtualLoading) {
                      return const CircularProgressIndicator();
                    }

                    if (state is PlanejamentoAtualEmpty) {
                      return Column(
                        children: [
                          const GutterLarge(),
                          const GutterLarge(),
                          const Text('Não existe planejamento neste mes'),
                          const Gutter(),
                          if (periodoState.periodo.month ==
                              DateTime.now().month)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(CreatePlanejamentoPage.route())
                                    .then((value) {
                                  // ignore: use_build_context_synchronously
                                  getIt<PlanejamentoAtualCubit>()
                                      .getPlanejamento(DateTime.now());
                                });
                              },
                              child: const Text('Criar planejamento'),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                context
                                    .read<PeriodoPlanejamentoCubit>()
                                    .setPeriodo(DateTime.now());
                              },
                              child: const Text('Voltar ao mes atual'),
                            )
                        ],
                      );
                    }

                    if (state is PlanejamentoAtualFailled) {
                      log(state.message);
                      return const Center(
                        child: Text('Falha ao carregar planejamento'),
                      );
                    }

                    if (state is PlanejamentoAtualSuccess) {
                      return _PlanejamentoViewWidget(
                        planejamento: state.planejamento,
                      );
                    }

                    return const Placeholder();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlanejamentoViewWidget extends StatelessWidget {
  const _PlanejamentoViewWidget({
    required this.planejamento,
  });

  final dynamic planejamento;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderPlanejamentoSection(
          planejamento: planejamento,
        ),
        InfoPlanejamentoSection(
          planejamento: planejamento,
        ),
        const Gutter(),
        const Divider(),
        const Gutter(),
        CategoriasPlanejamentoSection(
          planejamento: planejamento,
        ),
      ],
    );
  }
}
