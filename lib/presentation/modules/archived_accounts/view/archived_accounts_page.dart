import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/archived_accounts/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/archived_accounts/widgets/archived_accounts_body.dart';

/// {@template archived_accounts_page}
/// A description for ArchivedAccountsPage
/// {@endtemplate}
class ArchivedAccountsPage extends StatelessWidget {
  /// {@macro archived_accounts_page}
  const ArchivedAccountsPage({super.key});

  /// The static route for ArchivedAccountsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const ArchivedAccountsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchivedAccountsBloc(),
      child: const Scaffold(
        body: SafeArea(
          child: ArchivedAccountsView(),
        ),
      ),
    );
  }
}

/// {@template archived_accounts_view}
/// Displays the Body of ArchivedAccountsView
/// {@endtemplate}
class ArchivedAccountsView extends StatelessWidget {
  /// {@macro archived_accounts_view}
  const ArchivedAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ArchivedAccountsBody();
  }
}
