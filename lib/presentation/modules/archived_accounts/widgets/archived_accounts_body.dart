import 'package:app_financas/presentation/modules/conta/widgets/conta_header.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta_list_item.dart';
import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/archived_accounts/bloc/bloc.dart';

/// {@template archived_accounts_body}
/// Body of the ArchivedAccountsPage.
///
/// Add what it does
/// {@endtemplate}
class ArchivedAccountsBody extends StatelessWidget {
  /// {@macro archived_accounts_body}
  const ArchivedAccountsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContaHeader(
          title: 'Contas arquivadas',
          defaultColor: Theme.of(context).textTheme.titleLarge!.color!,
        ),
        const Expanded(child: _Body()),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: BlocBuilder<ArchivedAccountsBloc, ArchivedAccountsState>(
        bloc: context.read<ArchivedAccountsBloc>()
          ..add(const LoadArchivedAccountsEvent()),
        builder: (context, state) {
          if (state is ArchivedAccountsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ArchivedAccountsError) {
            return const Text(
                'Erro ao carregar ' 'a lista de contas arquivadas');
          }

          if (state is ArchivedAccountsLoaded) {
            return ListView.builder(
              itemCount: state.contas.length,
              itemBuilder: (context, index) {
                return ContaListItem(
                  conta: state.contas[index],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
