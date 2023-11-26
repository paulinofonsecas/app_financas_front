import 'package:app_financas/core/domain/entitys/balanco_mensal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../bloc/conta_bloc.dart';

part 'conta_list_header_state.dart';

class ContaListHeaderCubit extends Cubit<ContaListHeaderState> {
  late final ContaBloc _contasBloc;

  ContaListHeaderCubit(this._contasBloc)
      : super(const ContaListHeaderInitial(BalancoMensal(0, 0))) {
    _contasBloc.stream.listen((state) {
      if (state is CalcularSaldoMensalSuccess) {
        emit(ContaListHeaderSuccess(state.balanco));
      }

      if (state is CalcularSaldoMensalError) {
        emit(ContaListHeaderError());
      }

      if (state is CalcularSaldoMensalLoading) {
        emit(ContaListHeaderLoading());
      }

      if (state is CalcularSaldoMensalEmpty) {
        emit(ContaListHeaderEmpty());
      }
    });
  }

  void loadData(int mesIndex) {
    _contasBloc.add(const CalcularSaldoMensalEvent(1));
  }
}
