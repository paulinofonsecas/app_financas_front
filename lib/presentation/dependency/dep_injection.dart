import 'package:app_financas/core/data/provider/db/db_banco_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_banco_provider.dart';
import 'package:app_financas/core/data/services/banco_service.dart';
import 'package:app_financas/core/data/services/saldos_service.dart';
import 'package:app_financas/core/domain/services/i_banco_service.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/presentation/bloc/app/app_bloc.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_conta_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_tipo_movimento_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/movimentos_by_conta_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/create_conta_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/saldo_inicial_text_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/tipo_conta_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:app_financas/core/data/provider/db/db_categoria_provider.dart';
import 'package:app_financas/core/data/provider/db/db_conta_provider.dart';
import 'package:app_financas/core/data/provider/db/db_movimento_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_categoria_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_contas_provider.dart';
import 'package:app_financas/core/data/provider/interfaces/i_movimento_provider.dart';
import 'package:app_financas/core/data/services/categoria_service.dart';
import 'package:app_financas/core/data/services/conta_service.dart';
import 'package:app_financas/core/data/services/movimento_service.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/presentation/helders/http_helpers.dart';
import 'package:dio/dio.dart';

import '../modules/conta/bloc/bloc.dart';

var locator = GetIt.instance;

Future<void> dependencyInitialize() async {
  locator.registerLazySingleton<Dio>(() => makeDefaultDio());

  // Banco
  locator.registerLazySingleton<IBancoProvider>(() => DbBancoProvider());
  locator.registerLazySingleton<IBancoService>(() => BancoService(locator()));

  // Categoria
  locator
      .registerLazySingleton<ICategoriaProvider>(() => DbCategoriaProvider());
  locator.registerLazySingleton<ICategoriaService>(
      () => CategoriaService(locator()));

  // Movimentos
  locator.registerLazySingleton<IMovimentoProvider>(
      () => DbMovimentoProvider(locator()));
  locator.registerLazySingleton<IMovimentoService>(
      () => MovimentoService(provider: locator()));

  // Conta
  locator.registerLazySingleton<IContaProvider>(
      () => DbContaProvider(locator(), locator()));
  locator.registerLazySingleton<IContaService>(() => ContaService(locator()));

  // saldos
  locator.registerLazySingleton<ISaldosService>(() => SaldosService(locator()));

  // blocs
  locator.registerLazySingleton<AppBloc>(() => AppBloc());
  locator.registerLazySingleton<ContaBloc>(() => ContaBloc());
  locator.registerLazySingleton<MovimentoBloc>(() => MovimentoBloc(locator()));

  // cubits
  locator.registerLazySingleton<AppThemeCubit>(() => AppThemeCubit());
  locator.registerLazySingleton<HomePageCubit>(() => HomePageCubit());
  locator.registerLazySingleton<ChangeContaCubit>(() => ChangeContaCubit());
  locator
      .registerLazySingleton<ReajustarSaldoCubit>(() => ReajustarSaldoCubit());
  locator.registerLazySingleton<ChangeTipoMovimentoCubit>(
      () => ChangeTipoMovimentoCubit());
  locator.registerLazySingleton<MovimentosByContaCubit>(
      () => MovimentosByContaCubit(locator()));
  locator.registerFactory<InstituicaoFinanceiraCubit>(
      () => InstituicaoFinanceiraCubit(locator()));
  locator.registerFactory<CreateContaThemeCubit>(() => CreateContaThemeCubit());
  locator.registerFactory<CreateContaBloc>(() => CreateContaBloc());
  locator.registerFactory<SaldoInicialTextCubit>(() => SaldoInicialTextCubit());
  locator.registerFactory<TipoContaCubit>(() => TipoContaCubit());
}
