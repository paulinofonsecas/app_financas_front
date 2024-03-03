// ignore_for_file: depend_on_referenced_packages

import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'conta_event.dart';
part 'conta_state.dart';

class ContaBloc extends Bloc<ContaEvent, GContaState> {
  late final IContaService contaService;

  ContaBloc() : super(ContaInitial()) {
    contaService = getIt();

    on<ArquivarContaEvent>(_onArquivarConta);
    on<ListarContasEvent>(_onListarContas);
    on<ListarContasAtEvent>(_onListarContasAt);
    on<CalcularSaldoMensalEvent>(_onCalcularSaldoMensal);
    on<ChangeViewSaldoInHomePage>(_onChangeViewSaldoInHomePage);
  }

  _onArquivarConta(ArquivarContaEvent event, emit) async {
    var conta = event.conta;

    await contaService.updateConta(conta.copyWith(isArchived: true));

    emit(ArquivarContaSuccess());
  }

  _onListarContas(event, emit) async {
    emit(ListarContasLoading());
    var contas = await contaService.listContas();

    if (contas is Right) {
      if (contas.getOrElse(() => []).isNotEmpty) {
        emit(ListarContasSuccess(contas.getOrElse(() => [])));
      } else {
        emit(ListarContasEmpty());
      }
    } else {
      emit(
        ListarContasError(
          errorMessage: contas.fold((l) => l.toString(), (r) => ''),
        ),
      );
    }
  }

  _onListarContasAt(event, emit) async {
    var mes = event.mes;
    emit(ListarContasLoading());

    var contas = await contaService.listContas(mes);

    if (contas is Right) {
      if (contas.getOrElse(() => []).isNotEmpty) {
        emit(ListarContasSuccess(contas.getOrElse(() => [])));
      } else {
        emit(ListarContasEmpty());
      }
    } else {
      emit(
        ListarContasError(
          errorMessage: contas.fold((l) => l.toString(), (r) => ''),
        ),
      );
    }
  }

  _onCalcularSaldoMensal(event, emit) async {
    emit(CalcularSaldoMensalLoading());
    var mesIndex = event.mes;
    var result = await contaService.calcularBalancoMensal(mesIndex);

    if (result is Right) {
      var balancoMensal = result.getOrElse(() => BalancoMensal.fake());
      if (balancoMensal.saldo <= 0 && balancoMensal.saldoPrevisto <= 0) {
        emit(CalcularSaldoMensalEmpty());
      } else {
        emit(CalcularSaldoMensalSuccess(balancoMensal));
      }
    } else {
      emit(
        CalcularSaldoMensalError(),
      );
    }
  }

  _onChangeViewSaldoInHomePage(event, emit) async {
    var conta = event.conta;

    var result = await contaService.updateConta(conta);

    if (result is Right) {
      emit(ChangeViewSaldoInHomePageSuccess());
    } else {
      emit(ChangeViewSaldoInHomePageError());
    }
  }
}
