part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  const OnBoardingState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current OnBoardingState with property changes
  OnBoardingState copyWith({
    String? customProperty,
  }) {
    return OnBoardingState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template on_boarding_initial}
/// The initial state of OnBoardingState
/// {@endtemplate}
class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingError extends OnBoardingState {
  const OnBoardingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class OnBoardingSuccess extends OnBoardingState {
  const OnBoardingSuccess({required this.primeiraVez});

  final bool primeiraVez;

  @override
  List<Object> get props => [primeiraVez];
}

class OnBoardingSettingPrimeiraVezSuccess extends OnBoardingState {
  const OnBoardingSettingPrimeiraVezSuccess();
}

class OnBoardingSettingPrimeiraVezError extends OnBoardingState {
  const OnBoardingSettingPrimeiraVezError();
}
