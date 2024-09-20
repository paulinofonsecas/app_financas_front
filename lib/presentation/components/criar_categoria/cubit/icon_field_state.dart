part of 'icon_field_cubit.dart';

sealed class IconFieldState extends Equatable {
  const IconFieldState(this.icon);
  final IconData icon;

  @override
  List<Object> get props => [icon];
}

final class IconFieldInitial extends IconFieldState {
  const IconFieldInitial(super.icon);
}

final class IconFieldSelected extends IconFieldState {
  const IconFieldSelected(super.icon);
}
