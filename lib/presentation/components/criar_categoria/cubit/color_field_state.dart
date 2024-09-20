part of 'color_field_cubit.dart';

sealed class ColorFieldState extends Equatable {
  const ColorFieldState(this.color);
  final Color color;

  @override
  List<Object> get props => [color];
}

final class ColorFieldInitial extends ColorFieldState {
  const ColorFieldInitial(super.color);
}

final class ColorFieldSelected extends ColorFieldState {
  const ColorFieldSelected(super.color);
}
