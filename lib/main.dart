import 'package:app_financas/app/bindings/init_bindings.dart';
import 'package:app_financas/app/cubit/theme/app_theme_cubit.dart';
import 'package:app_financas/app/modules/splash/splash_page.dart';
import 'package:app_financas/dependency/dep_injection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app/bloc/app/app_bloc.dart';
import 'app/bloc/movimento/movimento_bloc.dart';

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeModeState = context.watch<AppThemeCubit>().state;

    return GetMaterialApp(
      title: 'Kwanza Gest',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      scrollBehavior: const ScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      }),
      themeMode: themeModeState.themeMode,
      initialBinding: InitBingings(),
      home: const SplashScreen(),
    );
  }
}
