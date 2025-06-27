/// A class that represents a localizable string with a base value and translations.
///
/// This is the core class used to define translation keys in your application.
/// Each [QuikLocaleString] contains a base string (fallback) and a map of
/// translations for different locale codes.
///
/// Example:
/// ```dart
/// static const helloWorld = QuikLocaleString(
///   base: "Hello",
///   translations: {
///     "fr": "Bonjour",
///     "es": "Hola",
///     "ta": "வணக்கம்",
///   },
/// );
/// ```
///
/// You can also define pluralized strings and strings with parameters:
/// ```dart
/// static const itemCount = QuikLocaleString(
///   base: "You have {count} items",
///   translations: {
///     "en_one": "You have {count} item",
///     "en_other": "You have {count} items",
///     "fr_one": "Vous avez {count} élément",
///     "fr_other": "Vous avez {count} éléments",
///   },
/// );
/// ```
class QuikLocaleString {
  /// The base/fallback string used when no translation is available
  final String base;

  /// Map of locale codes to their corresponding translations
  ///
  /// The keys can be:
  /// - Simple locale codes: 'en', 'fr', 'zh_CN'
  /// - Pluralized forms: 'en_zero', 'en_one', 'fr_many', etc.
  final Map<String, String> translations;

  /// Creates a new [QuikLocaleString] with the given base string and translations.
  ///
  /// [base] is the fallback string used when no translation is found.
  /// [translations] is a map where keys are locale codes (e.g., 'fr', 'es')
  /// and values are the translated strings.
  ///
  /// For pluralized forms, use locale codes with suffixes like:
  /// - zero: For 0 items
  /// - one: For 1 item
  /// - two: For 2 items
  /// - few: For a small number (varies by language)
  /// - many: For a large number (varies by language)
  /// - other: Default plural form for all other cases
  const QuikLocaleString({
    required this.base,
    required this.translations,
  });

  /// Gets the translation for the specified locale code.
  ///
  /// Returns the translated string if available, otherwise returns the [base] string.
  String getTranslation(String localeCode) {
    return translations[localeCode] ?? base;
  }

  /// Gets the plural translation for the specified locale code and count.
  ///
  /// Looks for pluralized versions using the pattern: "{localeCode}_{pluralForm}"
  /// where pluralForm can be 'zero', 'one', 'two', 'few', 'many', or 'other'.
  ///
  /// Falls back to regular translation if no plural form is found.
  String getPluralTranslation(String localeCode, int count) {
    final pluralForm = _getPluralForm(localeCode, count);
    final pluralKey = "${localeCode}_$pluralForm";

    return translations[pluralKey] ??
           translations[localeCode] ??
           base;
  }

  /// Determines the plural form for a given locale and count.
  ///
  /// This is a simplified implementation. For more complex plural rules,
  /// consider using the intl package's PluralCase.
  String _getPluralForm(String localeCode, int count) {
    // Simplified plural rules - can be extended for more languages
    switch (localeCode) {
      case 'en':
      case 'fr':
      case 'es':
      case 'de':
      case 'it':
      case 'pt':
        return count == 1 ? 'one' : 'other';
      case 'ru':
      case 'uk':
        if (count % 10 == 1 && count % 100 != 11) return 'one';
        if (count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20)) return 'few';
        return 'many';
      default:
        return count == 1 ? 'one' : 'other';
    }
  }
}
