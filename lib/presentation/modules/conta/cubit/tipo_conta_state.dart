part of 'tipo_conta_cubit.dart';

sealed class TipoContaState extends Equatable {
  const TipoContaState();

  @override
  List<Object> get props => [];
}

final class TipoContaInitial extends TipoContaState {}

final class TipoContaChanged extends TipoContaState {
  final int tipoContaId;

  const TipoContaChanged(this.tipoContaId);

  @override
  List<Object> get props => [tipoContaId];
}
