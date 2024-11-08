import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:app_financas/data/datasources/interfaces/i_saldos_provider.dart';
import 'package:app_financas/data/datasources/local/db/db_saldos_provider.dart';
import 'package:app_financas/data/repositories/banco_repository.dart';
import 'package:app_financas/data/repositories/categoria_repository.dart';
import 'package:app_financas/data/repositories/conta_repository.dart';
import 'package:app_financas/data/repositories/movimento_repository.dart';
import 'package:app_financas/data/repositories/objectivo_repository.dart';
import 'package:app_financas/data/repositories/planejamento_repository.dart';
import 'package:app_financas/data/repositories/saldos_repository.dart';
import 'package:app_financas/domain/repositories/i_banco_repository.dart';
import 'package:app_financas/domain/repositories/i_categoria_repository.dart';
import 'package:app_financas/domain/repositories/i_conta_repository.dart';
import 'package:app_financas/domain/repositories/i_movimento_repository.dart';
import 'package:app_financas/domain/repositories/i_objetivo_repository.dart';
import 'package:app_financas/domain/repositories/i_planejamento_repository.dart';
import 'package:app_financas/domain/repositories/i_saldos_repository.dart';
import 'package:app_financas/domain/usecases/i_banco_usecases.dart';
import 'package:app_financas/domain/usecases/i_categoria_usecase.dart';
import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:app_financas/domain/usecases/i_objetivo_usecase.dart';
import 'package:app_financas/domain/usecases/i_planejamento_usecase.dart';
import 'package:app_financas/domain/usecases/i_saldos_usecase.dart';
import 'package:app_financas/domain/usecases/movimento_usecases.dart';
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
import 'package:app_financas/data/datasources/local/db/db_banco_provider.dart';
import 'package:app_financas/data/datasources/local/db/db_categoria_provider.dart';
import 'package:app_financas/data/datasources/local/db/db_conta_provider.dart';
import 'package:app_financas/data/datasources/local/db/db_movimento_provider.dart';
import 'package:app_financas/data/datasources/local/db/db_objectivo_provider.dart';
import 'package:app_financas/data/datasources/local/db/db_planejamento_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_banco_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_categoria_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_contas_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_movimento_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_objectivo_provider.dart';
import 'package:app_financas/data/datasources/interfaces/i_planejamento_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../modules/conta/bloc/bloc.dart';

final getIt = GetIt.instance;

void dependencyInitialize() {
  getIt.registerLazySingleton<Dio>(() => makeDefaultDio());

  // Objectivos
  getIt.registerLazySingleton<IObjectivoProvider>(() => DBObjectivoProvider());
  getIt.registerLazySingleton<IObjectivoRepository>(
      () => ObjectivoRepository(getIt()));
  getIt.registerLazySingleton<IObjectivoUseCases>(
      () => ObjectivoUseCases(getIt()));

  // Planejamento
  getIt.registerLazySingleton<IPlanejamentoProvider>(
      () => DBPlanejamentoProvider(
            movimentoProvider: getIt(),
            categoriaService: getIt(),
          ));
  getIt.registerLazySingleton<IPlanejamentoRepository>(
      () => PlanejamentoRepository(provider: getIt()));
  getIt.registerLazySingleton<IPlanejamentoUseCases>(
      () => PlanejamentoUseCases(getIt()));

  // Banco
  getIt.registerLazySingleton<IBancoProvider>(() => DbBancoProvider());
  getIt.registerLazySingleton<IBancoRepository>(() => BancoRepository(getIt()));
  getIt.registerLazySingleton<IBancoUseCases>(() => BancoUseCases(getIt()));

  getIt.registerLazySingleton(() => ContasCubit());
  getIt.registerLazySingleton(() => PlanejamentoAtualCubit(getIt()));
  // Categoria
  getIt.registerLazySingleton<ICategoriaProvider>(() => DbCategoriaProvider());
  getIt.registerLazySingleton<ICategoriaRepository>(
      () => CategoriaRepository(getIt()));
  getIt.registerLazySingleton<ICategoriaUseCases>(
      () => CategoriaUseCases(getIt()));

  // Movimentos
  getIt.registerLazySingleton<IMovimentoProvider>(
      () => DbMovimentoProvider(getIt()));
  getIt.registerLazySingleton<IMovimentoRepository>(
      () => MovimentoRepository(provider: getIt()));
  getIt.registerLazySingleton<IMovimentoUseCases>(
      () => MovimentoUsecases(getIt()));

  // Conta
  getIt.registerLazySingleton<IContaProvider>(() => DbContaProvider(getIt()));
  getIt.registerLazySingleton<IContaRepository>(
      () => ContaRepository(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<IContaUseCases>(() => ContaUseCases(getIt()));

  // blocs
  getIt.registerLazySingleton<AppBloc>(() => AppBloc());
  getIt.registerLazySingleton<ContaBloc>(() => ContaBloc());
  getIt.registerLazySingleton<MovimentoBloc>(() => MovimentoBloc(getIt()));
  getIt.registerLazySingleton(() => MovimentosPendentesBloc());

  getIt.registerLazySingleton<ISaldosProvider>(
      () => DBSaldosProvider(getIt(), getIt()));
  getIt.registerLazySingleton<ISaldosRepository>(
      () => SaldosRepository(getIt(), getIt()));
  getIt.registerLazySingleton<ISaldosUseCases>(() => SaldosUseCases(getIt()));

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
