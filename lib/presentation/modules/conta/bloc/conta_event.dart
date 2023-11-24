part of 'conta_bloc.dart';

abstract class ContaEvent  extends Equatable {
  const ContaEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_conta_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomContaEvent extends ContaEvent {
  /// {@macro custom_conta_event}
  const CustomContaEvent();
}
