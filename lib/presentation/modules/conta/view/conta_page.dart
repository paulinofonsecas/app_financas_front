import 'package:app_financas/presentation/components/periodo_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta_body.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../widgets/conta_header.dart';

/// {@template conta_page}
/// A description for ContaPage
/// {@endtemplate}
class ContaPage extends StatelessWidget {
  /// {@macro conta_page}
  const ContaPage({super.key});

  /// The static route for ContaPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ContaPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContaBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: const SafeArea(
          child: ContaView(),
        ),
      ),
    );
  }
}

/// {@template conta_view}
/// Displays the Body of ContaView
/// {@endtemplate}
class ContaView extends StatelessWidget {
  /// {@macro conta_view}
  const ContaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ContaHeader(),
        const Gutter(),
        PeriodoPickerWidget(
          periodoMes: 'Novembro',
          onLeftTap: () {},
          onRightTap: () {},
          defaultColor: Colors.white,
        ),
        const Gutter(),
        const ContaBody(),
      ],
    );
  }
}
