part of 'select_data_cubit.dart';

sealed class SelectDataState extends Equatable {
  final DateTime date;
  const SelectDataState(this.date);

  @override
  List<Object> get props => [date];
}

final class SelectDataInitial extends SelectDataState {
  const SelectDataInitial(super.date);

  @override
  List<Object> get props => [date];
}

final class SelectDataSuccess extends SelectDataState {
  const SelectDataSuccess(super.date);

  @override
  List<Object> get props => [date];
}
