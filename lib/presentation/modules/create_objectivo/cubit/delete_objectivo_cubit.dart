import 'package:app_financas/domain/entities/objectivo.dart';
import 'package:app_financas/domain/usecases/i_objetivo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_objectivo_state.dart';

class DeleteObjectivoCubit extends Cubit<DeleteObjectivoState> {
  DeleteObjectivoCubit(this.service) : super(DeleteObjectivoInitial());

  final IObjectivoUseCases service;

  void deleteObjectivo(Objectivo objectivoModel) async {
    emit(DeleteObjectivoLoading());

    final result = await service.deleteObjectivo(objectivoModel.id);

    result.fold(
      (l) => emit(DeleteObjectivoError(l.message)),
      (r) => emit(DeleteObjectivoSuccess()),
    );
  }
}
