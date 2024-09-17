import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:app_financas/core/data/provider/db/db_banco_provider.dart';
import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_conta_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/db/db_objectivo_provider.dart';
import 'package:app_financas/core/data/provider/db/db_planejamento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_banco_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_categoria_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_objectivo_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_planejamento_provider.dart';
import 'package:app_financas/core/data/services/banco_service.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/data/services/conta_service.dart';
import 'package:app_financas/core/data/services/movimento_service.dart';
import 'package:app_financas/core/data/services/objectivo_service.dart';
import 'package:app_financas/core/data/services/planejamento_service.dart';
import 'package:app_financas/core/data/services/saldos_service.dart';
import 'package:app_financas/core/domain/services/i_banco_service.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/domain/services/i_objetivo_service.dart';
import 'package:app_financas/core/domain/services/i_planejamento_service.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/helders/http_helpers.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_conta_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_tipo_movimento_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/movimentos_by_conta_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/create_conta_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/saldo_inicial_text_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/tipo_conta_cubit.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/bloc/movimentos_pendentes_bloc.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/cubit/planejamento_atual_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../modules/conta/bloc/bloc.dart';

final getIt = GetIt.instance;

void dependencyInitialize() {
  getIt.registerLazySingleton<Dio>(() => makeDefaultDio());

  // Objectivos
  getIt.registerLazySingleton<IObjectivoProvider>(() => DBObjectivoProvider());
  getIt.registerLazySingleton<IObjectivoService>(
      () => ObjectivoService(getIt()));

  // Planejamento
  getIt.registerLazySingleton<IPlanejamentoProvider>(
      () => DBPlanejamentoProvider(
            movimentoProvider: getIt(),
            categoriaService: getIt(),
          ));
  getIt.registerLazySingleton<IPlanejamentoService>(
      () => PlanejamentoService(provider: getIt()));

  getIt.registerLazySingleton(() => ContasCubit());
  getIt.registerLazySingleton(() => PlanejamentoAtualCubit(getIt()));

  // Banco
  getIt.registerLazySingleton<IBancoProvider>(() => DbBancoProvider());
  getIt.registerLazySingleton<IBancoService>(() => BancoService(getIt()));

  // Categoria
  getIt.registerLazySingleton<ICategoriaProvider>(() => DbCategoriaProvider());
  getIt.registerLazySingleton<ICategoriaService>(
      () => CategoriaService(getIt()));

  // Movimentos
  getIt.registerLazySingleton<IMovimentoProvider>(
      () => DbMovimentoProvider(getIt()));
  getIt.registerLazySingleton<IMovimentoService>(
      () => MovimentoService(provider: getIt()));

  // Conta
  getIt.registerLazySingleton<IContaProvider>(() => DbContaProvider(getIt()));
  getIt.registerLazySingleton<IContaService>(
      () => ContaService(getIt(), getIt(), getIt()));

  // saldos
  getIt.registerLazySingleton<ISaldosService>(() => SaldosService(getIt()));

  // blocs
  getIt.registerLazySingleton<AppBloc>(() => AppBloc());
  getIt.registerLazySingleton<ContaBloc>(() => ContaBloc());
  getIt.registerLazySingleton<MovimentoBloc>(() => MovimentoBloc(getIt()));
  getIt.registerLazySingleton(() => MovimentosPendentesBloc());

  // cubits
  getIt.registerLazySingleton<AppThemeCubit>(() => AppThemeCubit());
  getIt.registerLazySingleton<HomePageCubit>(() => HomePageCubit());
  getIt.registerLazySingleton<ChangeContaCubit>(() => ChangeContaCubit());
  getIt.registerLazySingleton<ReajustarSaldoCubit>(() => ReajustarSaldoCubit());
  getIt.registerLazySingleton<ChangeTipoMovimentoCubit>(
      () => ChangeTipoMovimentoCubit());
  getIt.registerLazySingleton<MovimentosByContaCubit>(
      () => MovimentosByContaCubit(getIt()));
  getIt.registerFactory<InstituicaoFinanceiraCubit>(
      () => InstituicaoFinanceiraCubit(getIt()));
  getIt.registerFactory<CreateContaThemeCubit>(() => CreateContaThemeCubit());
  getIt.registerFactory<CreateContaBloc>(() => CreateContaBloc());
  getIt.registerFactory<SaldoInicialTextCubit>(() => SaldoInicialTextCubit());
  getIt.registerFactory<TipoContaCubit>(() => TipoContaCubit());
}
