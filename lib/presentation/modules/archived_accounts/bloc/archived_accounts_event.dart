part of 'archived_accounts_bloc.dart';

abstract class ArchivedAccountsEvent extends Equatable {
  const ArchivedAccountsEvent();

  @override
  List<Object> get props => [];
}

/// {@template custom_archived_accounts_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class LoadArchivedAccountsEvent extends ArchivedAccountsEvent {
  /// {@macro custom_archived_accounts_event}
  const LoadArchivedAccountsEvent();
}
