import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.conta});

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contrained) {
        return Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        conta.banco.imgAsset ?? 'assets/imgs/bancos/BAI.png',
                        width: 25,
                        height: 25,
                      ),
                      const GutterTiny(),
                      Text(
                        conta.banco.acronimo ?? 'N/A',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Gutter(),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        conta.nome,
                        maxLines: 1,
                        minFontSize: 10,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildEntradasESaidas(context, conta),
              const Divider(),
              _buildSaldoAtual(context, conta),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEntradasESaidas(BuildContext context, Conta conta) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: FutureBuilder<double>(
              future: context
                  .read<HomePageCubit>()
                  .getSaldoTotalEntradasByConta(conta.id),
              builder: (context, snapshot) {
                var saldo = 0.0;

                if (snapshot.hasData) {
                  saldo = snapshot.data ?? 0;
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return Column(
                  children: [
                    const Text(
                      'Entradas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(numberFormat.format(saldo)),
                  ],
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: FutureBuilder<double>(
              future: context
                  .read<HomePageCubit>()
                  .getSaldoTotalSaidasByConta(conta.id),
              builder: (context, snapshot) {
                var saldo = 0.0;

                if (snapshot.hasData) {
                  saldo = snapshot.data ?? 0;
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return Column(
                  children: [
                    const Text(
                      'Saidas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(numberFormat.format(saldo)),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaldoAtual(BuildContext context, Conta conta) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Saldo: ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
            Text(
              numberFormat.format(conta.saldo),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
