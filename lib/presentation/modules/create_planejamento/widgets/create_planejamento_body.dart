import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/create_planejamento/bloc/create_planejamento_bloc.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/cubit/create_planejamento_stepper_controll_cubit.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/create_planejamento_stepper.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/categorias_step.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/discribuicao_step/distribuicao_step.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/finish_step/finish_step.dart';
import 'package:app_financas/presentation/modules/create_planejamento/widgets/steps/plafound_step.dart';
import 'package:app_financas/presentation/modules/planejamento/planejamento.dart';
import 'package:flutter/material.dart';

/// {@template create_planejamento_body}
/// Body of the CreatePlanejamentoPage.
///
/// Add what it does
/// {@endtemplate}
class CreatePlanejamentoBody extends StatefulWidget {
  /// {@macro create_planejamento_body}
  const CreatePlanejamentoBody({super.key});

  @override
  State<CreatePlanejamentoBody> createState() => _CreatePlanejamentoBodyState();
}

class _CreatePlanejamentoBodyState extends State<CreatePlanejamentoBody> {
  var activeStep = 0;
  final _stepScreens = [
    const PlafoundStep(),
    const CategoriasStep(),
    const DistribuicaoStep(),
    const FinishStep(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreatePlanejamentoBloc, CreateNewPlanejamentoState>(
          listener: (context, state) {
            if (state is CreateNewPlanejamentoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
        BlocListener<CreatePlanejamentoStepperControllCubit,
            CreatePlanejamentoStepperControllState>(
          listener: (context, state) {
            if (state is CreatePlanejamentoStepperControllNext) {
              if (activeStep < 4) {
                setState(() {
                  activeStep++;
                });
              }
            } else if (state is CreatePlanejamentoStepperControllBack) {
              if (activeStep > 0) {
                setState(() {
                  activeStep--;
                });
              }
            }
          },
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CreatePlanejamentoStepper(activeStep2: activeStep),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: IndexedStack(
                    index: activeStep,
                    // sizing: StackFit.expand,
                    children: _stepScreens,
                  ),
                ),
              ],
            ),
          ),
          if (context.watch<CreatePlanejamentoBloc>().state
                  is CreateNewPlanejamentoInitial ||
              context.watch<CreatePlanejamentoBloc>().state
                  is CreateNewPlanejamentoError)
            Align(
              alignment: Alignment.bottomRight,
              child: _ControlButtons(activeStep: activeStep),
            ),
        ],
      ),
    );
  }
}

class _ControlButtons extends StatelessWidget {
  const _ControlButtons({
    required this.activeStep,
  });

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              if (activeStep > 0) {
                context.read<CreatePlanejamentoStepperControllCubit>().back();
              }

              if (activeStep == 0) {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              activeStep == 0 ? 'Cancelar' : 'Anterior',
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          FilledButton(
            child: Text(
              activeStep == 3 ? 'Finalizar' : 'Continuar',
            ),
            onPressed: () {
              if (activeStep < 3) {
                context.read<CreatePlanejamentoStepperControllCubit>().next();
              }

              if (activeStep == 3) {
                context
                    .read<CreatePlanejamentoBloc>()
                    .add(FinishCreatePlanejamentoEvent(
                      context
                          .read<CreatePlanejamentoCubit>()
                          .state
                          .planejamento,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
