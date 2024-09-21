import 'package:app_financas/presentation/modules/estatisticas/cubit/filtro_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/estatistica_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'controller/estatisticas_page_controller.dart';

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
    return BlocProvider(
      create: (context) => FiltroCubit(),
      child: Scaffold(
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
    return EstatisticaBody();
  }
}
