import 'package:app_financas/presentation/components/periodo_picker_widget.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_list_header_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_periodo_picker_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta_body.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../widgets/conta_header.dart';

/// {@template conta_page}
/// A description for ContaPage
/// {@endtemplate}
class ContaPage extends StatefulWidget {
  /// {@macro conta_page}
  const ContaPage({super.key});

  /// The static route for ContaPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ContaPage());
  }

  @override
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  late final ContaListHeaderCubit headerCubit;

  @override
  void initState() {
    super.initState();
    headerCubit = ContaListHeaderCubit(locator());
  }

  @override
  void dispose() {
    headerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContaBloc(),
        ),
        BlocProvider(
          create: (context) => ContaPeriodoPickerCubit(),
        ),
        BlocProvider.value(
          value: headerCubit,
        ),
      ],
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
        BlocBuilder<ContaPeriodoPickerCubit, ContaPeriodoPickerState>(
          builder: (context, state) {
            return PeriodoPickerWidget(
              periodoMes: getMonthName(state.mes),
              onLeftTap: () {
                context.read<ContaPeriodoPickerCubit>().previousMonth();
              },
              onRightTap: () {
                context.read<ContaPeriodoPickerCubit>().nextMonth();
              },
              defaultColor: Colors.white,
            );
          },
        ),
        const Gutter(),
        const ContaBody(),
      ],
    );
  }
}
