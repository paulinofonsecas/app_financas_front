part of 'archived_accounts_bloc.dart';

/// {@template archived_accounts_state}
/// ArchivedAccountsState description
/// {@endtemplate}
class ArchivedAccountsState extends Equatable {
  /// {@macro archived_accounts_state}
  const ArchivedAccountsState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ArchivedAccountsState with property changes
  ArchivedAccountsState copyWith({
    String? customProperty,
  }) {
    return ArchivedAccountsState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

class ArchivedAccountsInitial extends ArchivedAccountsState {
  const ArchivedAccountsInitial() : super();
}

class ArchivedAccountsLoading extends ArchivedAccountsState {
  const ArchivedAccountsLoading() : super();
}

class ArchivedAccountsError extends ArchivedAccountsState {
  const ArchivedAccountsError() : super();
}

class ArchivedAccountsLoaded extends ArchivedAccountsState {
  const ArchivedAccountsLoaded(this.contas) : super();

  final List<Conta> contas;

  @override
    List<Object> get props => [contas];
}

