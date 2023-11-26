// ignore_for_file: overridden_fields, annotate_overrides

part of 'conta_periodo_picker_cubit_cubit.dart';

sealed class ContaPeriodoPickerState extends Equatable {
  final int mes;

  const ContaPeriodoPickerState(this.mes);

  @override
  List<Object> get props => [mes];
}

final class ContaPeriodoPickerInitial extends ContaPeriodoPickerState {
  final int mes;
  const ContaPeriodoPickerInitial(this.mes) : super(mes);

  @override
  List<Object> get props => [mes];
}

final class ContaPeriodoPickerChanged extends ContaPeriodoPickerState {
  final int mes;

  const ContaPeriodoPickerChanged(this.mes) : super(mes);

  @override
  List<Object> get props => [mes];
}
