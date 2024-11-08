import 'package:app_financas/score/domain/entitys/objectivo.dart';
import 'package:app_financas/score/domain/services/i_objetivo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_objectivo_state.dart';

class DeleteObjectivoCubit extends Cubit<DeleteObjectivoState> {
  DeleteObjectivoCubit(this.service) : super(DeleteObjectivoInitial());

  final IObjectivoService service;

  void deleteObjectivo(Objectivo objectivoModel) async {
    emit(DeleteObjectivoLoading());

    final result = await service.deleteObjectivo(objectivoModel.id);

    result.fold(
      (l) => emit(DeleteObjectivoError(l.message)),
      (r) => emit(DeleteObjectivoSuccess()),
    );
  }
}
