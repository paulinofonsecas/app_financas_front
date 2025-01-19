part of 'localization_cubit.dart';

sealed class LocalizationState extends Equatable {
  const LocalizationState({required this.locale});

  final SupportedLocale locale;

  @override
  List<Object> get props => [locale];
}

final class LocalizationInitial extends LocalizationState {
  LocalizationInitial() : super(locale: SupportedLocale.supportedLocales.first);
}

final class LocalizationChanged extends LocalizationState {
  const LocalizationChanged(SupportedLocale locale) : super(locale: locale);
}
