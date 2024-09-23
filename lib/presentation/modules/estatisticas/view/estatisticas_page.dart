import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/filtro_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/select_tipo_movimente_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/week_bar_chart_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/estatistica_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../controller/estatisticas_page_controller.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  late final EstatisticasPageController controller;

  @override
  void initState() {
    controller = Get.put(EstatisticasPageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FiltroCubit(),
        ),
        BlocProvider(
          create: (context) => WeekBarChartCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => SelectTipoMovimentoCubit(),
        ),
      ],
      child: const Scaffold(
        body: EstatisticaView(),
      ),
    );
  }
}

class EstatisticaView extends StatelessWidget {
  const EstatisticaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const EstatisticaBody();
  }
}
