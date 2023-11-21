import 'package:app_financas/core/data/services/saldos_service.dart';
import 'package:app_financas/core/domain/services/i_saldos_service.dart';
import 'package:app_financas/presentation/bloc/app/app_bloc.dart';
import 'package:app_financas/presentation/bloc/conta/conta_bloc.dart';
import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
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

var locator = GetIt.instance;

Future<void> dependencyInitialize() async {
  locator.registerLazySingleton<Dio>(() => makeDefaultDio());

  // Movimentos
  locator
      .registerLazySingleton<IMovimentoProvider>(() => DbMovimentoProvider());
  locator.registerLazySingleton<IMovimentoService>(
      () => MovimentoService(provider: locator()));

  // Categoria
  locator
      .registerLazySingleton<ICategoriaProvider>(() => DbCategoriaProvider());
  locator.registerLazySingleton<ICategoriaService>(
      () => CategoriaService(locator()));

  // Conta
  locator
      .registerLazySingleton<IContaProvider>(() => DbContaProvider(locator()));
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
}
