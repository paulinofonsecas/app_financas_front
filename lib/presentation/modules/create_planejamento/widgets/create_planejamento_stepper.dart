import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreatePlanejamentoStepper extends StatefulWidget {
  const CreatePlanejamentoStepper({
    super.key,
    required this.activeStep2,
    this.onStepTapped,
  });

  final int activeStep2;
  final Function(int index)? onStepTapped;

  @override
  State<CreatePlanejamentoStepper> createState() =>
      _CreatePlanejamentoStepperState();
}

class _CreatePlanejamentoStepperState extends State<CreatePlanejamentoStepper> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EasyStepper(
            activeStep: widget.activeStep2,
            lineStyle: LineStyle(
              lineLength: 30,
              lineSpace: 4,
              lineType: LineType.dotted,
              finishedLineColor: Colors.pink.withOpacity(0.5),
              unreachedLineColor: Colors.blueGrey.withOpacity(0.5),
              activeLineColor: Colors.blueGrey.withOpacity(0.5),
            ),
            finishedStepBackgroundColor:
                Theme.of(context).colorScheme.primaryContainer,
            finishedStepIconColor:
                Theme.of(context).colorScheme.onPrimaryContainer,
            borderThickness: 2,
            internalPadding: 15,
            showStepBorder: true,
            showLoadingAnimation: false,
            stepRadius: 25,
            steps: const [
              EasyStep(
                icon: Icon(FontAwesomeIcons.sackDollar),
                title: 'Plafound',
                enabled: true,
                // showBadge: true,
              ),
              EasyStep(
                icon: Icon(FontAwesomeIcons.layerGroup),
                title: 'Categorias',
                enabled: true,
              ),
              EasyStep(
                icon: Icon(FontAwesomeIcons.scaleUnbalanced),
                title: 'Repartir',
                enabled: true,
              ),
              EasyStep(
                icon: Icon(FontAwesomeIcons.check),
                enabled: true,
              ),
            ],
            onStepReached: widget.onStepTapped,
          ),
        ],
      ),
    );
  }
}
