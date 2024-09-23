part of 'week_bar_chart_cubit.dart';

sealed class WeekBarChartState extends Equatable {
  const WeekBarChartState();

  @override
  List<Object> get props => [];
}

final class WeekBarChartInitial extends WeekBarChartState {}

final class WeekBarChartLoading extends WeekBarChartState {}

final class WeekBarChartEmpty extends WeekBarChartState {}

final class WeekBarChartError extends WeekBarChartState {
  const WeekBarChartError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

final class WeekBarChartSuccess extends WeekBarChartState {
  const WeekBarChartSuccess({
    required this.movimentos,
  });

  final Map<int, double> movimentos;

  @override
  List<Object> get props => [movimentos];
}
