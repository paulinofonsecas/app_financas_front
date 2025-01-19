part of 'select_language_cubit.dart';

/// {@template select_language}
/// SelectLanguageState description
/// {@endtemplate}
class SelectLanguageState extends Equatable {
  /// {@macro select_language}
  const SelectLanguageState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current SelectLanguageState with property changes
  SelectLanguageState copyWith({
    String? customProperty,
  }) {
    return SelectLanguageState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}
/// {@template select_language_initial}
/// The initial state of SelectLanguageState
/// {@endtemplate}
class SelectLanguageInitial extends SelectLanguageState {
  /// {@macro select_language_initial}
  const SelectLanguageInitial() : super();
}
