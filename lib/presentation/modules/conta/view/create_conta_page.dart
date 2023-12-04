import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/mostrar_na_tela_inicial_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/saldo_inicial_text_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/tipo_conta_cubit.dart';
import 'package:app_financas/presentation/modules/conta/widgets/create_conta_body.dart';
import 'package:flutter/material.dart';

import '../cubit/create_conta_theme_cubit.dart';

class CreateContaPage extends StatefulWidget {
  const CreateContaPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const CreateContaPage());
  }

  @override
  State<CreateContaPage> createState() => _CreateContaPageState();
}

class _CreateContaPageState extends State<CreateContaPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateContaThemeCubit(),
        ),
        BlocProvider(
          create: (context) => InstituicaoFinanceiraCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => TipoContaCubit(),
        ),
        BlocProvider(
          create: (context) => SaldoInicialTextCubit(),
        ),
        BlocProvider(
          create: (context) => MostrarNaTelaInicialCubit(),
        ),
      ],
      child: const CreateContaView(),
    );
  }
}

class CreateContaView extends StatelessWidget {
  const CreateContaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContaThemeCubit, CreateContaThemeState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: state.color,
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: const CreateContaBody(),
        );
      },
    );
  }
}
