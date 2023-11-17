part of 'app_bloc.dart';

@immutable
sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppChangeBottomNavIndexEvent extends AppEvent {
  final int index;

  const AppChangeBottomNavIndexEvent(this.index);

  @override
  List<Object> get props => [index];
}

class AppChangeThemeModeEvent extends AppEvent {
  final ThemeMode target;

  const AppChangeThemeModeEvent(this.target);

  @override
  List<Object> get props => [target];
}
