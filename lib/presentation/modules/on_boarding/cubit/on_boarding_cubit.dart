import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  FutureOr<void> isPrimeiraVez() async {
    emit(OnBoardingLoading());

    try {
      final Box<bool> box = await Hive.openBox('onBoarding');
      final primeiraVez = box.get('primeiraVez', defaultValue: true)!;

      if (primeiraVez) {
        emit(const OnBoardingSuccess(primeiraVez: true));
      } else {
        emit(const OnBoardingSuccess(primeiraVez: false));
      }
    } catch (e) {
      emit(OnBoardingError('Ocorreu um erro ao inicializar o app: $e'));
    }
  }

  Future<void> setPrimeiraVez() async {
    emit(OnBoardingLoading());

    try {
      final Box<bool> box = await Hive.openBox('onBoarding');
      await box.put('primeiraVez', false);
      emit(const OnBoardingSettingPrimeiraVezSuccess());
    } catch (e) {
      emit(const OnBoardingSettingPrimeiraVezError());
    }
  }
}
