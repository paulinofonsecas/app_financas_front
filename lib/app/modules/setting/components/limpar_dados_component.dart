import 'package:app_financas/app/bindings/init_bindings.dart';
import 'package:app_financas/app/modules/splash/splash_page.dart';
import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LimparDadosWidget extends StatelessWidget {
  const LimparDadosWidget({
    super.key,
  });

  Future<void> _deleteAllData() async {
    await Hive.deleteBoxFromDisk(kMovimentosBox);
    await Hive.deleteBoxFromDisk(kContasBox);
    await Hive.deleteBoxFromDisk(kCategoriasEntradaBox);
    await Hive.deleteBoxFromDisk(kCategoriasSaidaBox);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
                onPressed: () async {
                  await _deleteAllData();
                  Get.offAll(
                    () => const SplashScreen(),
                    binding: InitBingings(),
                  );
                },
                child: const Text('Limpar'),
              ),
            ],
          ),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
      ),
      child: const Text('Limpar dados'),
    );
  }
}
