part of 'app_bloc.dart';

@immutable
sealed class AppState extends Equatable {
  final int bottomNavIndex;

  const AppState({this.bottomNavIndex = 0});

  @override
  List<Object?> get props => [bottomNavIndex];
}

final class AppInitial extends AppState {}

final class AppBottomNavChanged extends AppState {
  final int index;

  const AppBottomNavChanged(this.index) : super(bottomNavIndex: index);
}
