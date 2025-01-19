import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/domain/entities/supported_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleBottomSheet extends StatelessWidget {
  const LocaleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LocalizationCubit>().state.locale;
    final locales = SupportedLocale.supportedLocales;

    return BottomSheet(
      onClosing: () {},
      showDragHandle: true,
      builder: (_) => ListView(
        children: locales.map((locale) {
          return ListTile(
            title: Text(locale.country),
            subtitle: Text(locale.language),
            leading: Text(
              locale.flag,
              style: const TextStyle(fontSize: 24),
            ),
            trailing: currentLocale.country == locale.country
                ? const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  )
                : null,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Deseja alterar a localização?'),
                  content: const Text('A alteração irá reiniciar o app.'),
                  actions: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('Alterar'),
                      onPressed: () {
                        context.read<LocalizationCubit>().changeLocale(locale);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
