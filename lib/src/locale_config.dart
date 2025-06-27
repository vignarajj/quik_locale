import 'package:flutter/material.dart';

/// Configuration class for QuikLocale initialization.
///
/// This class defines the base locale (fallback) and supported locales
/// for your application's localization.
///
/// Example:
/// ```dart
/// final config = LocaleConfig(
///   baseLocale: QuikLocale.english,
///   supportedLocales: [
///     QuikLocale.english,
///     QuikLocale.french,
///     QuikLocale.spanish,
///   ],
/// );
/// ```
///
/// The LocaleConfig class is responsible for managing the locale settings
/// and provides utility methods for locale code conversions.
class LocaleConfig {
  /// The base/fallback locale used when no translation is available
  final Locale baseLocale;

  /// List of all supported locales in the application
  final List<Locale> supportedLocales;

  /// Creates a new [LocaleConfig] with the specified base and supported locales.
  ///
  /// [baseLocale] is the fallback locale used when translations are missing.
  /// [supportedLocales] is the list of all locales your app supports.
  ///
  /// The [baseLocale] should be included in [supportedLocales].
  ///
  /// Example:
  /// ```dart
  /// final config = LocaleConfig(
  ///   baseLocale: QuikLocale.english,
  ///   supportedLocales: [
  ///     QuikLocale.english,
  ///     QuikLocale.french,
  ///     QuikLocale.spanish,
  ///     Locale('de'), // German
  ///     Locale('zh', 'CN'), // Chinese Simplified
  ///   ],
  /// );
  /// ```
  const LocaleConfig({
    required this.baseLocale,
    required this.supportedLocales,
  }) : assert(
    supportedLocales.length > 0,
    'supportedLocales cannot be empty',
  );

  /// Gets the locale code from a [Locale] object.
  ///
  /// Returns the language code, or language_country if country is specified.
  ///
  /// Examples:
  /// - For Locale('en') returns 'en'
  /// - For Locale('zh', 'CN') returns 'zh_CN'
  static String getLocaleCode(Locale locale) {
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  /// Creates a [Locale] from a locale code string.
  ///
  /// Supports both language codes ('en') and language_country codes ('en_US').
  static Locale localeFromCode(String code) {
    final parts = code.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(parts[0]);
  }
}
