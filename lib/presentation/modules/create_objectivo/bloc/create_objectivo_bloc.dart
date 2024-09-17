import 'dart:async';

import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/core/domain/services/i_objetivo_service.dart';
import 'package:app_financas/presentation/modules/create_objectivo/view/pre_create_objectivo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'create_objectivo_event.dart';
part 'create_objectivo_state.dart';

class CreateObjectivoBloc
    extends Bloc<CreateObjectivoEvent, CreateObjectivoState> {
  CreateObjectivoBloc(this.preObj, this.service)
      : super(CreateObjectivoInitial()) {
    on<CustomCreateObjectivoEvent>(_onCustomCreateObjectivoEvent);
    on<SaveObjectivoEvent>(_onSaveObjectivoEvent);
  }

  final IObjectivoService service;

  final PreCreateObjModel? preObj;
  var objectivoModel = Objectivo.empty();
  final formKey = GlobalKey<FormState>();

  FutureOr<void> _onCustomCreateObjectivoEvent(
    CustomCreateObjectivoEvent event,
    Emitter<CreateObjectivoState> emit,
  ) {}

  FutureOr<void> _onSaveObjectivoEvent(
    SaveObjectivoEvent event,
    Emitter<CreateObjectivoState> emit,
  ) async {
    emit(CreateObjectivoLoading());

    final result = await service.createObjectivo(event.objectivo);

    result.fold(
      (l) => emit(
          const CreateObjectivoError('Ocorreu um erro ao criar o objectivo')),
      (r) => emit(CreateObjectivoSuccess()),
    );
  }
}
