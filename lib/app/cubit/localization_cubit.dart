import 'dart:convert';

import 'package:app_financas/domain/entities/supported_locale.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  Future<void> changeLocale(SupportedLocale newLocale) async {
    final sp = getIt<SharedPreferences>();

    await sp.setString(
      'locale',
      json.encode(newLocale.toJson()),
    );

    Intl.defaultLocale = newLocale.locale.toString();
    emit(LocalizationChanged(newLocale));
  }

  SupportedLocale getLocale() {
    late SupportedLocale locale;
    final sp = getIt<SharedPreferences>();

    try {
      if (sp.containsKey('locale')) {
        final rawLocale = sp.getString('locale')!;

        final storageLocale = SupportedLocale.fromJson(
          json.decode(rawLocale).cast<String, String>(),
        );

        locale = storageLocale;
      } else {
        locale = LocalizationInitial().locale;
      }
    } catch (e) {
      locale = LocalizationInitial().locale;
    }

    Intl.defaultLocale = locale.locale.toString();
    return locale;
  }

  void init() async {
    final locale = getLocale();

    Intl.defaultLocale = locale.locale.toString();

    emit(LocalizationChanged(locale));
  }
}
