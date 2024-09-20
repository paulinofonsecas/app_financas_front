part of 'objectivos_bloc.dart';

abstract class ObjectivosEvent  extends Equatable {
  const ObjectivosEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_objectivos_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomObjectivosEvent extends ObjectivosEvent {
  /// {@macro custom_objectivos_event}
  const CustomObjectivosEvent();
}
