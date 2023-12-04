part of 'obs_text_cubit.dart';

sealed class ObsTextState extends Equatable {
  const ObsTextState(this.obs);

  final String obs;

  @override
  List<Object> get props => [];
}

final class ObsTextInitial extends ObsTextState {
  const ObsTextInitial(String obs) : super(obs);
}

final class ObsTextChanged extends ObsTextState {
  const ObsTextChanged(String obs) : super(obs);
}
