import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/conta/widgets/botao_salvar_widget.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta.dart';
import 'package:app_financas/presentation/modules/conta/widgets/cor_conta_widget.dart';
import 'package:app_financas/presentation/modules/conta/widgets/incluir_na_tela_inicial_widget.dart';
import 'package:app_financas/presentation/modules/conta/widgets/instituicao_financeira_widget.dart';
import 'package:app_financas/presentation/modules/conta/widgets/nome_text_field_widget.dart';
import 'package:app_financas/presentation/modules/conta/widgets/tipo_conta_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class MainContentWidget extends StatefulWidget {
  const MainContentWidget({super.key});

  @override
  State<MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> {
  // final TextEditingController descricaoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final heightPadding = MediaQuery.of(context).viewPadding.bottom;

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                const InstituicaoFinanceiraWidget(),
                const Divider(),
                NomeTextFieldWidget(
                  textController: nomeController,
                ),
                const Divider(),
                // _DescriptionTextFieldWidget(
                //   textController: descricaoController,
                // ),
                // const Divider(),
                const TipoContaWidget(),
                const Divider(),
                const CorContaWidget(),
                const Divider(),
                const IncluirNaTelaInicialWidget(),
                const Divider(),
                const GutterLarge(),
                BotaoSalvarWidget(onTap: () {
                  var createContaBloc = context.read<CreateContaBloc>();

                  createContaBloc.add(GravarContaEvent(
                    context: context,
                    nomeConta: nomeController.text,
                  ));
                }),
                SizedBox(height: heightPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
