// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/components/my_divider.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/reajustar_saldo_cubit.dart';

class ReajustarSaldoDialog extends StatefulWidget {
  const ReajustarSaldoDialog({
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  State<ReajustarSaldoDialog> createState() => _ReajustarSaldoDialogState();
}

class _ReajustarSaldoDialogState extends State<ReajustarSaldoDialog> {
  late final TextEditingController _newSaldoController;
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    symbol: 'Kz',
  );

  @override
  void initState() {
    super.initState();
    _newSaldoController = TextEditingController();

    _newSaldoController.addListener(() {
      context
          .read<ReajustarSaldoCubit>()
          .updateNewSaldo(_formatter.getUnformattedValue().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReajustarSaldoCubit>(),
      child: BlocConsumer<ReajustarSaldoCubit, ReajustarSaldoState>(
        listenWhen: (old, state) =>
            old != state && state is ReajustarSaldoSuccess,
        listener: (context, state) {
          if (state is ReajustarSaldoSuccess) {
            context.read<ContaBloc>().add(ListarContasEvent());
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Reajustar saldo',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        context
                            .read<ReajustarSaldoCubit>()
                            .reajustarSaldo(widget.conta);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.circleCheck,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const Gutter(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Novo saldo',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: _MoneyTextField(
                            newSaldoController: _newSaldoController,
                            formatter: _formatter,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _newSaldoController.clear();
                          },
                          icon: const Icon(
                            FontAwesomeIcons.circleXmark,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const GutterTiny(),
                MyDivider(),
                const GutterTiny(),
                BlocBuilder<ReajustarSaldoCubit, ReajustarSaldoState>(
                  buildWhen: (prev, state) =>
                      state is SaldoChanged && prev.saldo != state.saldo,
                  builder: (context, state) {
                    return Text(
                      _getReajusteMessage(state),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                      ),
                    );
                  },
                ),
                const Gutter(),
                _TransacaoDeReajusteWidget(conta: widget.conta),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getReajusteMessage(ReajustarSaldoState state) {
    var estado = (state.saldo - widget.conta.saldo) > 0;
    return 'Para ajustar o seu saldo, será criada'
        ' uma ${estado ? 'receita' : 'despesa'} de ajuste.';
  }
}

class _MoneyTextField extends StatelessWidget {
  const _MoneyTextField({
    required this.newSaldoController,
    required this.formatter,
  });

  final TextEditingController newSaldoController;
  final CurrencyTextInputFormatter formatter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newSaldoController,
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: '0,00',
      ),
      inputFormatters: [formatter],
    );
  }
}

class _TransacaoDeReajusteWidget extends StatelessWidget {
  const _TransacaoDeReajusteWidget({
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            BlocBuilder<ReajustarSaldoCubit, ReajustarSaldoState>(
              buildWhen: (previous, current) =>
                  current is SaldoChanged && previous.saldo != current.saldo,
              builder: (context, state) {
                var estado = (state.saldo - conta.saldo) > 0;
                return Container(
                  decoration: BoxDecoration(
                    color: estado
                        ? Theme.of(context).colorScheme.primary
                        : Colors.red[800],
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.tools,
                    color: Colors.white,
                    size: 18,
                  ),
                );
              },
            ),
            const GutterSmall(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reajuste',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  shortDateFormat.format(DateTime.now()),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        BlocBuilder<ReajustarSaldoCubit, ReajustarSaldoState>(
          builder: (context, state) {
            if (state is SaldoChangedWithError) {
              return Text(
                'Error',
              );
            }

            if (state is SaldoChanged) {
              return Text(
                numberFormat.format(state.saldo - conta.saldo),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            return const Text(
              '0,00',
            );
          },
        ),
      ],
    );
  }
}
