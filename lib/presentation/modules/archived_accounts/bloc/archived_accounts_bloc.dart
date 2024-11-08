import 'dart:async';

import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'archived_accounts_event.dart';
part 'archived_accounts_state.dart';

class ArchivedAccountsBloc
    extends Bloc<ArchivedAccountsEvent, ArchivedAccountsState> {
  ArchivedAccountsBloc() : super(const ArchivedAccountsInitial()) {
    _contaService = getIt();
    on<LoadArchivedAccountsEvent>(_onLoadArchivedAccountsEvent);
  }

  late final IContaUseCases _contaService;

  FutureOr<void> _onLoadArchivedAccountsEvent(
    LoadArchivedAccountsEvent event,
    Emitter<ArchivedAccountsState> emit,
  ) async {
    emit(const ArchivedAccountsLoading());
    final result = await _contaService.listArchivedContas();

    result.fold(
      (l) => emit(const ArchivedAccountsError()),
      (r) => emit(ArchivedAccountsLoaded(r)),
    );
  }
}
