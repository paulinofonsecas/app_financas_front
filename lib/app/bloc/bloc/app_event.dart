part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class AppChangeBottomNav extends AppEvent {
  final int index;

  AppChangeBottomNav(this.index);
}
