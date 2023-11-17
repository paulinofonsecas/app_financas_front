// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<ChangeAppBottomNavEvent>(onAppChangeBottomNav);
  }

  void onAppChangeBottomNav(event, emit) {
    emit(AppBottomNavChanged(event.index));
  }
}
