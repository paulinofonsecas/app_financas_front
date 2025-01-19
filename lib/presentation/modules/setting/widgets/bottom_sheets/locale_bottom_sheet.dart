import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/domain/entities/supported_locale.dart';
import 'package:app_financas/presentation/modules/select_language/widgets/language_list_item.dart';
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
          return LanguageListItem(currentLocale: currentLocale, locale: locale);
        }).toList(),
      ),
    );
  }
}
