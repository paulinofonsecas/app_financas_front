import 'dart:async';

import 'package:app_financas/domain/entities/objectivo.dart';
import 'package:app_financas/domain/usecases/i_objetivo_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_objectivo_event.dart';
part 'create_objectivo_state.dart';

class CreateObjectivoBloc
    extends Bloc<CreateObjectivoEvent, CreateObjectivoState> {
  CreateObjectivoBloc({
    required this.service,
    Objectivo? objectivo,
  }) : super(CreateObjectivoInitial()) {
    objectivoModel = objectivo ?? Objectivo.empty();
    on<CustomCreateObjectivoEvent>(_onCustomCreateObjectivoEvent);
    on<SaveObjectivoEvent>(_onSaveObjectivoEvent);
  }

  final IObjectivoUseCases service;

  late Objectivo objectivoModel;
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
