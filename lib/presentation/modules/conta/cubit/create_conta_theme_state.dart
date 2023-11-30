part of 'create_conta_theme_cubit.dart';

sealed class CreateContaThemeState extends Equatable {
  const CreateContaThemeState(this.color);

  final Color color;

  @override
  List<Object> get props => [color];
}

final class CreateContaThemeInitial extends CreateContaThemeState {
  const CreateContaThemeInitial(super.color);
}

final class CreateContaThemeChanged extends CreateContaThemeState {
  const CreateContaThemeChanged(super.color);
}
