// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/carteira/components/header_section.dart';
import 'package:app_financas/presentation/modules/carteira/components/movimentos_list_section.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_conta_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_tipo_movimento_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/movimentos_by_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'components/carteira_card_section.dart';

class CarteiraPage extends StatefulWidget {
  const CarteiraPage({super.key});

  @override
  State<CarteiraPage> createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  late final CarteiraPageController carteiraController;

  @override
  void initState() {
    carteiraController = Get.put(CarteiraPageController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => getIt<ContasCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<MovimentosByContaCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChangeContaCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChangeTipoMovimentoCubit>(),
        ),
      ],
      child: GetBuilder(
        init: carteiraController,
        id: 'geral',
        builder: (context) {
          return const Column(
            children: [
              HeaderSection(),
              CarteiraCardSection(),
              MovimentosListSection(),
            ],
          );
        },
      ),
    );
  }
}
