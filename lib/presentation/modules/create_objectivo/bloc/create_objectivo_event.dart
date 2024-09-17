part of 'create_objectivo_bloc.dart';

abstract class CreateObjectivoEvent extends Equatable {
  const CreateObjectivoEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_create_objectivo_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomCreateObjectivoEvent extends CreateObjectivoEvent {
  const CustomCreateObjectivoEvent();
}

class SaveObjectivoEvent extends CreateObjectivoEvent {
  final Objectivo objectivo;
  const SaveObjectivoEvent(this.objectivo);

  @override
  List<Object> get props => [objectivo];
}
