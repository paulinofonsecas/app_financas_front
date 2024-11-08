import 'package:app_financas/score/domain/entitys/conta.dart';
import 'package:app_financas/score/domain/services/i_conta_service.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conta_mostrar_na_tela_inicial_state.dart';

class ContaMostrarNaTelaInicialCubit
    extends Cubit<ContaMostrarNaTelaInicialState> {
  late final IContaService _contaService;

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
