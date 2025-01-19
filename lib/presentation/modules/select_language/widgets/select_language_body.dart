import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/domain/entities/supported_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_list_item.dart';

/// {@template select_language_body}
/// Body of the SelectLanguagePage.
///
/// Add what it does
/// {@endtemplate}
class SelectLanguageBody extends StatelessWidget {
  /// {@macro select_language_body}
  const SelectLanguageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LocalizationCubit>().state.locale;
    final locales = SupportedLocale.supportedLocales;

    return ListView(
      children: locales.map((locale) {
        return LanguageListItem(
          locale: locale,
          currentLocale: currentLocale,
        );
      }).toList(),
    );
  }
}
