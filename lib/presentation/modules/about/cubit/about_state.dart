part of 'about_cubit.dart';

/// {@template about}
/// AboutState description
/// {@endtemplate}
class AboutState extends Equatable {
  /// {@macro about}
  const AboutState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current AboutState with property changes
  AboutState copyWith({
    String? customProperty,
  }) {
    return AboutState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}
/// {@template about_initial}
/// The initial state of AboutState
/// {@endtemplate}
class AboutInitial extends AboutState {
  /// {@macro about_initial}
  const AboutInitial() : super();
}
