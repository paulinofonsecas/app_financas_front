import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conta_mostrar_na_tela_inicial_state.dart';

class ContaMostrarNaTelaInicialCubit
    extends Cubit<ContaMostrarNaTelaInicialState> {
  late final IContaUseCases _contaService;

  ContaMostrarNaTelaInicialCubit()
      : super(const ContaMostrarNaTelaInitial(false)) {
    _contaService = getIt();
  }

  void revelState(Conta conta) {
    emit(ContaMostrarNaTelaChanged(conta.showInSoma ?? false));
  }

  void changeMostrarNaTelaicial(Conta conta) async {
    var value = !(conta.showInSoma ?? false);
    await _contaService.updateConta(conta.copyWith(
      showInSoma: value,
    ));

    emit(ContaMostrarNaTelaChanged(value));
  }
}
