import 'package:app_financas/presentation/bindings/init_bindings.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/planejamento.dart';
import 'package:app_financas/presentation/modules/setting/cubit/change_theme_color_cubit.dart';
import 'package:app_financas/presentation/modules/splash/splash_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeModeState = context.watch<AppThemeCubit>().state;

    return GetMaterialApp(
      title: 'Poupa+',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: context.watch<ChangeThemeColorCubit>().state.color,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: context.watch<ChangeThemeColorCubit>().state.color,
          brightness: Brightness.light,
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
