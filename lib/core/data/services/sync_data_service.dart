import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/http/http_movimento_provider.dart';
import 'package:app_financas/core/data/provider/http/http_setup_provider.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_sync_data_service.dart';
import 'package:app_financas/helders/http_helpers.dart';

import '../provider/db/db_categoria_provider.dart';
import '../provider/db/db_conta_provider.dart';
import '../provider/interfaces/i_categoria_provider.dart';
import '../provider/interfaces/i_contas_provider.dart';
import '../provider/interfaces/i_movimento_provider.dart';
import '../provider/interfaces/i_setup_provider.dart';

class SyncDataService implements ISyncDataService {
  late ISetupProvider setupService;
  late IContaProvider contaService;
  late ICategoriaProvider categoriasService;
  late IMovimentoProvider movimentoService;

  @override
  Future<void> syncData() async {
    var dio = makeDefaultDio();
    setupService = HttpSetupProvider(dio);
    movimentoService = HttpMovimentoProvider(dio);

    var setup = await setupService.setup();
    await _syncSetup(setup.getOrElse(() => SetupConfiguration.local()));

    var movimentos = await movimentoService.listMovimentos();
    await _syncMovimentos(movimentos.getOrElse(() => []));
  }

  Future<void> _syncSetup(SetupConfiguration setup) async {
    if (setup.isLocal) return;
    var categorias = setup.categorias;
    var contas = setup.contas;

    print('salvando categorias');
    categoriasService = DbCategoriaProvider();
    for (var categoria in categorias) {
      categoriasService.saveSaidaCategoria(categoria);
    }

    print('salvando contas');
    contaService = DbContaProvider();
    for (var conta in contas) {
      contaService.saveConta(conta);
    }
  }

  Future<void> _syncMovimentos(List<Movimento> movimentoList) async {
    print('salvando movimentos');
    movimentoService = DbMovimentoProvider();
    for (var movimento in movimentoList) {
      movimentoService.saveMovimento(movimento);
    }
  }
}
