part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class AppChangeBottomNavIndexEvent extends AppEvent {
  final int index;

  AppChangeBottomNavIndexEvent(this.index);
}
