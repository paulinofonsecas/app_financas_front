import 'dart:ui';

class SupportedLocale {
  final String flag;
  final String country;
  final String language;
  final String languageCode;
  final String countryCode;
  final String currencySymbol;

  SupportedLocale({
    required this.flag,
    required this.country,
    required this.language,
    required this.languageCode,
    required this.countryCode,
    this.currencySymbol = 'R\$',
  });

  Locale get locale {
    return Locale(languageCode, countryCode);
  }

  Map<String, String> toJson() {
    return {
      'flag': flag,
      'country': country,
      'language': language,
      'languageCode': languageCode,
      'countryCode': countryCode,
      'currencySymbol': currencySymbol
    };
  }

  static SupportedLocale fromJson(Map<String, String> json) {
    return SupportedLocale(
      flag: json['flag']!,
      country: json['country']!,
      language: json['language']!,
      languageCode: json['languageCode']!,
      countryCode: json['countryCode']!,
      currencySymbol: json['currencySymbol'] ?? '\$',
    );
  }

  static List<SupportedLocale> get supportedLocales {
    return [
      // Angola
      SupportedLocale(
        flag: 'a',
        country: 'Angola',
        language: 'Português',
        languageCode: 'pt',
        countryCode: 'AO',
        currencySymbol: 'Kz',
      ),
      // Brazil
      SupportedLocale(
        flag: 'b',
        country: 'Brasil',
        language: 'Português',
        languageCode: 'pt',
        countryCode: 'BR',
        currencySymbol: 'R\$',
      ),
      // Portugal
      SupportedLocale(
        flag: 'p',
        country: 'Portugal',
        language: 'Português',
        languageCode: 'pt',
        countryCode: 'PT',
        currencySymbol: '€',
      ),
    ];
  }
}
