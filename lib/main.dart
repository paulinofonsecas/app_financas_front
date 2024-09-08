import 'package:app_financas/app.dart';
import 'package:app_financas/presentation/bloc/app/app_bloc.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'presentation/cubit/bottom_sheet_conta_cubit.dart';
import 'presentation/modules/conta/bloc/conta_bloc.dart';
import 'presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'presentation/modules/registar_transacao/cubit/listar_categoria_cubit.dart';
import 'presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';

class BlocObserverWithLogger extends BlocObserver {
  final Logger logger;

  BlocObserverWithLogger({required this.logger});

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d('${bloc.runtimeType} $change');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await  initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';
  await Hive.initFlutter('./app_financas_db');

  dependencyInitialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AppBloc>(),
        ),
        BlocProvider(
          create: (context) => RegistarTransacaoBloc(),
        ),
        BlocProvider(
          create: (context) => getIt<MovimentoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AppThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ContaBloc>(),
        ),
        BlocProvider(
          create: (c) => getIt<ReajustarSaldoCubit>(),
        ),
        BlocProvider(
          create: (context) => CreateContaBloc(),
        ),
        BlocProvider(
          create: (context) => ContaMostrarNaTelaInicialCubit(),
        ),
        BlocProvider(
          create: (context) => BottomSheetContaCubit(),
        ),
        BlocProvider(
          create: (context) => ListarCategoriaCubit(),
        ),
        BlocProvider(
          create: (context) => SelectCategoriaCubit(),
        ),
      ],
      child: _buildApp(),
    ),
  );
}

Builder _buildApp() {
  return Builder(builder: (context) {
    return DevicePreview(
      enabled: true,
      builder: (c) => const MyApp(),
    );
  });
}
