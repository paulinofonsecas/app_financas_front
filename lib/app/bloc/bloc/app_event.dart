part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class ChangeAppBottomNavEvent extends AppEvent {
  final int index;

  ChangeAppBottomNavEvent(this.index);
}
