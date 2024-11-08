import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/objectivo.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/create_objectivo/view/create_objectivo_page.dart';
import 'package:app_financas/presentation/modules/objectivos/bottom_sheets/adicionar_fundos_sheet.dart';
import 'package:app_financas/presentation/modules/objectivos/cubit/listar_objetivos_cubit.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/usage_progress.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class ListaObjectivoItem extends StatelessWidget {
  const ListaObjectivoItem({super.key, required this.objectivo});

  final Objectivo objectivo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        surfaceTintColor: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(
              CreateObjectivoPage.route(
                objectivo: objectivo,
              ),
            )
                .then((value) {
              // ignore: use_build_context_synchronously
              context.read<ListarObjetivosCubit>().loadData();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderWidget(objectivo: objectivo),
                const Gutter(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data final do objetivo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      shortDateFormat.format(objectivo.finalDate),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Gutter(),
                UsageProgress(
                  finalValue: objectivo.targetValue,
                  actualValue: objectivo.currentValue + objectivo.initialValue,
                  color: objectivo.color,
                  footerDescription: 'Guardado',
                  showFooter: false,
                ),
                const GutterSmall(),
                const Divider(),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          AdicionarFundosSheet.show(
                            context,
                            objectivo,
                          ).then((value) {
                            // ignore: use_build_context_synchronously
                            context.read<ListarObjetivosCubit>().loadData();
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Adicionar fundos',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .push(CreateObjectivoPage.route(
                            objectivo: objectivo,
                          ))
                              .then((value) {
                            // ignore: use_build_context_synchronously
                            context.read<ListarObjetivosCubit>().loadData();
                          });
                        },
                        icon: const Icon(Icons.info_outline),
                        label: const Text(
                          'Detalhes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    required this.objectivo,
  });

  final Objectivo objectivo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: objectivo.color.withOpacity(.08),
          radius: 25,
          child: Center(
            child: Icon(
              objectivo.icon,
              color: objectivo.color,
              size: 25,
            ),
          ),
        ),
        const Gutter(),
        Expanded(
          child: AutoSizeText(
            objectivo.name,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Gutter(),
        Text(
          '${objectivo.percent.toStringAsFixed(2)}%',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
