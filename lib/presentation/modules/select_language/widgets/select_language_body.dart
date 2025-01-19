import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/domain/entities/supported_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
        return InkWell(
          onTap: () {
            context.read<LocalizationCubit>().changeLocale(locale);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  height: 42,
                  child: ClipRRect(
                    child: locale.flagURL == null
                        ? null
                        : SvgPicture.network(
                            locale.flagURL!,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.country,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('${locale.language} (${locale.currencySymbol})'),
                  ],
                ),
                const Spacer(),
                if (currentLocale.country == locale.country)
                  const Icon(Icons.check_circle_outline, color: Colors.green),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
