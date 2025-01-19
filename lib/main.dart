// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:app_financas/app/app.dart';
import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/firebase_options.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/setting/cubit/change_theme_color_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'presentation/cubit/bottom_sheet_conta_cubit.dart';
import 'presentation/modules/conta/bloc/conta_bloc.dart';
import 'presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'presentation/modules/registar_transacao/cubit/listar_categoria_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupApplicationAndConfigurations();

  final initialDependencies = [
    BlocProvider(
      create: (_) => getIt<AppBloc>(),
    ),
    BlocProvider(
      create: (_) => getIt<LocalizationCubit>(),
    ),
    BlocProvider(
      create: (context) => RegistarTransacaoBloc(),
    ),
    BlocProvider(
      create: (context) => getIt<MovimentoBloc>(),
    ),
    BlocProvider(
      create: (context) => AppThemeCubit(),
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
      create: (context) =>
          ChangeThemeColorCubit(Colors.purple)..loadDefaultThemeColor(),
    ),
  ];

  runApp(
    MultiBlocProvider(
      providers: initialDependencies,
      child: DevicePreview(
        enabled: !kReleaseMode && !Platform.isAndroid,
        builder: (c) => const MyApp(),
      ),
    ),
  );
}

Future<void> setupApplicationAndConfigurations() async {
  await dependencyInitialize();

  if (!kIsWeb && Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }
  }

  await initializeDateFormatting('pt_AO', null);
  // Intl.defaultLocale =
  //     const Locale.fromSubtags(languageCode: 'pt', scriptCode: 'AO').toString();
  await Hive.initFlutter('./app_financas_db');
}
