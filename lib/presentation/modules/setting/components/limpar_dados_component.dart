import 'package:app_financas/core/data/provider/db/helpers/db_hive_box_names.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
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
    await Hive.deleteBoxFromDisk(kBancoBox);
    await Hive.deleteBoxFromDisk(kSetupBox);
    await Hive.deleteBoxFromDisk(kCategoriasEntradaBox);
    await Hive.deleteBoxFromDisk(kCategoriasSaidaBox);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.warning),
      onPressed: () {
        showDialog(
          context: context,
          builder: (myContext) => AlertDialog(
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
                  Navigator.of(myContext).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () {
                  _deleteAllData().then(
                    (value) async {
                      await getIt.reset();
                      Get.deleteAll();
                      Get.reset();
                      // ignore: use_build_context_synchronously
                    },
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
      label: const Text('Limpar dados'),
    );
  }
}
