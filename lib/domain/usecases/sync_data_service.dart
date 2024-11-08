// ignore_for_file: avoid_print

import 'package:app_financas/data/datasources/interfaces/i_categoria_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_contas_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_movimento_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_setup_provider.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/entities/sertup_configuration.dart';
import 'package:app_financas/domain/usecases/i_sync_datasource.dart';
import 'package:hive/hive.dart';

class SyncDataUseCases implements ISyncDataUseCases {
  late ISetupProvider setupService;
  late IContaProvider contaService;
  late ICategoriaProvider categoriasService;
  late IMovimentoProvider movimentoService;

  @override
  Future<void> syncData() async {
    await Hive.deleteFromDisk();

    var setup = await setupService.setup();
    await _syncSetup(setup.getOrElse(() => SetupConfiguration.local()));

    var movimentos = await movimentoService.listMovimentos();
    await _syncMovimentos(movimentos.getOrElse(() => []));
  }

  Future<void> _syncSetup(SetupConfiguration setup) async {
    if (setup.isLocal) return;

    var contas = setup.contas;

    for (var conta in contas) {
      await contaService.saveConta(conta);
    }
  }

  Future<void> _syncMovimentos(List<Movimento> movimentoList) async {
    for (var movimento in movimentoList) {
      await movimentoService.saveMovimento(movimento);
    }
  }
}
