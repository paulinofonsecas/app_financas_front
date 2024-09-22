part of 'change_theme_color_cubit.dart';

sealed class ChangeThemeColorState extends Equatable {
  const ChangeThemeColorState(this.color);

  final Color color;

  @override
  List<Object> get props => [color];
}

final class ChangeThemeColorInitial extends ChangeThemeColorState {
  const ChangeThemeColorInitial(super.color);
}

final class ChangeThemeColorSuccess extends ChangeThemeColorState {
  const ChangeThemeColorSuccess(super.color);
}
