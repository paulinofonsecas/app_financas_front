import 'package:app_financas/presentation/bindings/init_bindings.dart';
import 'package:app_financas/presentation/bloc/app/app_bloc.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/splash/splash_page.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:device_preview/device_preview.dart';
import 'package:intl/intl.dart';

import 'presentation/modules/conta/bloc/conta_bloc.dart';
import 'presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'presentation/modules/registar_transacao/cubit/bottom_sheet_conta_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInitialize();

  initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';
  await Hive.initFlutter('./app_financas_db');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<AppBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<MovimentoBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<AppThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<ContaBloc>(),
        ),
        BlocProvider(
          create: (c) => locator<ReajustarSaldoCubit>(),
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
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (c) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeModeState = context.watch<AppThemeCubit>().state;

    return GetMaterialApp(
      title: 'KzGest',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
      ),
      scrollBehavior: const ScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      }),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      themeMode: themeModeState.themeMode,
      initialBinding: InitBingings(),
      home: const SplashScreen(),
    );
  }
}
