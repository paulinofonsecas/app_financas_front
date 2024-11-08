// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/domain/entities/objectivo.dart';
import 'package:app_financas/domain/usecases/i_objetivo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'adicionar_fundos_state.dart';

class AdicionarFundosCubit extends Cubit<AdicionarFundosState> {
  AdicionarFundosCubit(
    this._objectivoService,
  ) : super(AdicionarFundosInitial());

  final IObjectivoUseCases _objectivoService;

  void adicionarFundos(Objectivo objectivo, double fundo) async {
    emit(AdicionarFundosLoading());

    final result = await _objectivoService.adicionarFundo(objectivo, fundo);

    result.fold(
      (l) => emit(AdicionarFundosError(l.message)),
      (r) => emit(AdicionarFundosSuccess()),
    );
  }
}
