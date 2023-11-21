part of 'show_money_cubit.dart';

sealed class ShowMoneyState extends Equatable {
  final bool value;
  const ShowMoneyState(this.value);

  @override
  List<Object> get props => [value];
}

final class ShowMoneyChangeValue extends ShowMoneyState {
  const ShowMoneyChangeValue(bool value) : super(value);

  @override
  List<Object> get props => [value];
}
