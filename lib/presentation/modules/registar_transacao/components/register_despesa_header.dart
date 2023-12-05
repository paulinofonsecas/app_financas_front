import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/valor_transacao_cubit.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var switchCubit = context.watch<SwitchTransacaoCubit>();
    var isEntrada = switchCubit.state is SwitchTransacaoEntrada;

    var isDark = Theme.of(context).brightness == Brightness.dark;

    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      constraints: BoxConstraints(
        minHeight: size.height * .17,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.shadow
            : isEntrada
                ? kVerdeColor
                : kVermelhaColor,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _CancelarButton(),
              _SwitchTransactionButton(),
            ],
          ),
          GutterLarge(),
          _ValorTextWidget(),
          Gutter(),
        ],
      ),
    );
  }
}

class _CancelarButton extends StatelessWidget {
  const _CancelarButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Cancelar',
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ValorTextWidget extends StatelessWidget {
  const _ValorTextWidget();

  @override
  Widget build(BuildContext context) {
    var valorTransacaoCubit = context.read<ValorTransacaoCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SwitchTransacaoCubit, SwitchTransacaoState>(
          builder: (context, state) {
            var isEntrada = state is SwitchTransacaoEntrada;
            return Text(
              'Valor da ${isEntrada ? 'receita' : 'despesa'}',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white,
              ),
            );
          },
        ),
        TextFormField(
          onChanged: valorTransacaoCubit.changeValorTransacao,
          focusNode: FocusNode(canRequestFocus: true),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: '0,00',
            hintStyle: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            prefixText: 'Kz ',
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}

class _SwitchTransactionButton extends StatelessWidget {
  const _SwitchTransactionButton();

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SwitchTransacaoCubit>();

    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          bloc.switchTransationType();
        },
        child: BlocBuilder<SwitchTransacaoCubit, SwitchTransacaoState>(
          builder: (context, state) {
            var isEntrada = state is SwitchTransacaoEntrada;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 3,
                horizontal: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(90)),
                color: isEntrada ? kVerdeForteColor : kVermelhaForteColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEntrada ? 'Receita' : 'Despesa',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const GutterSmall(),
                  const Icon(
                    Icons.sync,
                    color: Colors.white,
                    weight: 1,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
