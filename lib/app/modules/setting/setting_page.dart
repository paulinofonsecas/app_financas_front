import 'package:app_financas/app/bindings/init_bindings.dart';
import 'package:app_financas/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topCenter,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text('Limpar dados'),
                          content: const Text(
                            'Deseja realmente redefinir toda a base de dados?',
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () {
                                Hive.deleteFromDisk();
                                Navigator.of(context).pop();
                                Get.offAll(const SplashScreen());
                              },
                              child: const Text('Limpar'),
                            ),
                          ]),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Limpar dados'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
