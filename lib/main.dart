import 'package:app_financas/app/bindings/init_bindings.dart';
import 'package:app_financas/app/controllers/global_theme_controller.dart';
import 'package:app_financas/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kwanzagest',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(useMaterial3: true),
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialBinding: InitBingings(),
      home: const SplashScreen(),
    );
  }
}
