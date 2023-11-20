part of 'app_theme_cubit.dart';

sealed class AppThemeState extends Equatable {
  final ThemeMode themeMode;

  const AppThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

final class AppThemeChanged extends AppThemeState {
  const AppThemeChanged(ThemeMode themeMode) : super(themeMode);

  @override
  List<Object?> get props => [themeMode];
}
