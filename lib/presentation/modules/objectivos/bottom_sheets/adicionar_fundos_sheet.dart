import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/objectivos/bottom_sheets/widgets/add_fundos_body.dart';
import 'package:app_financas/presentation/modules/objectivos/cubit/adicionar_fundos_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class AdicionarFundosSheet extends HookWidget {
  const AdicionarFundosSheet(this.objectivo, {super.key});

  final Objectivo objectivo;

  static Future<dynamic> show(BuildContext context, Objectivo objectivo) {
    final size = MediaQuery.of(context).size;

    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      constraints: BoxConstraints.expand(
        height: size.height * 0.9,
      ),
      isScrollControlled: true,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SelectContaCubit(1),
          ),
          BlocProvider(
            create: (context) => AdicionarFundosCubit(getIt()),
          ),
        ],
        child: AdicionarFundosSheet(objectivo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatterState = useState(
      CurrencyTextInputFormatter(
        NumberFormat.currency(symbol: 'Kz'),
      ),
    );
    final formKey = useState(GlobalKey<FormState>());

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              objectivo.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const GutterSmall(),
            const Divider(),
            const GutterSmall(),
            BlocConsumer<AdicionarFundosCubit, AdicionarFundosState>(
              listener: (context, state) {
                if (state is AdicionarFundosSuccess) {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fundos adicionados com sucesso'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AdicionarFundosLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is AdicionarFundosError) {
                  return const Center(
                    child: Text('Ocorreu um erro ao adicionar os fundos'),
                  );
                }

                return AddFundosBody(
                  formatterState: formatterState,
                  formKey: formKey,
                  objectivo: objectivo,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
