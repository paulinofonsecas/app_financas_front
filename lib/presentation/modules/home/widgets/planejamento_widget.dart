import 'dart:developer';

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/home/abbas/components/abba_header.dart';
import 'package:app_financas/presentation/modules/home/cubit/show_planejamento_in_home_page_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/cubit/planejamento_atual_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/view/planejamento_page.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/info_planejamento_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class PlanejamentoWidget extends StatelessWidget {
  const PlanejamentoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: BlocListener<PlanejamentoAtualCubit, PlanejamentoAtualState>(
        bloc: getIt<PlanejamentoAtualCubit>(),
        listener: (context, state) {
          if (state is PlanejamentoAtualSuccess ||
              state is PlanejamentoAtualEmpty) {
            context.read<ShowPlanejamentoInHomePageCubit>().getPlanejamento();
          }
        },
        child: BlocBuilder<ShowPlanejamentoInHomePageCubit,
            ShowPlanejamentoInHomePageState>(
          bloc: context.read<ShowPlanejamentoInHomePageCubit>()
            ..getPlanejamento(),
          builder: (context, state) {
            if (state is ShowPlanejamentoInHomePageLoading) {
              return const Center(
                child: SizedBox.square(
                  dimension: 25,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ShowPlanejamentoInHomePageEmpty) {
              return const SizedBox();
            }

            if (state is ShowPlanejamentoInHomePageError) {
              log(state.message);
              return const SizedBox();
            }

            if (state is ShowPlanejamentoInHomePageSuccess) {
              return Column(
                children: [
                  const Gutter(),
                  AbbaHeader(
                    title: 'Planejamento',
                    verMaisAction: () {
                      Navigator.of(context).push(PlanejamentoPage.route());
                    },
                  ),
                  const Gutter(),
                  InkWell(
                    onTap: () =>
                        Navigator.of(context).push(PlanejamentoPage.route()),
                    child: InfoPlanejamentoSection(
                      planejamento: state.planejamento,
                    ),
                  ),
                  const Gutter(),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
