import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'quik_locale_string.dart';
import 'locale_config.dart';

/// The main QuikLocale class that handles localization functionality.
///
/// This class provides static methods for initialization, locale management,
/// and translation operations. It acts as the central hub for all
/// localization features in your Flutter application.
class QuikLocale {
  static LocaleConfig? _config;
  static Locale? _currentLocale;
  static final List<VoidCallback> _listeners = [];

  // Common locale constants
  // Major European Languages
  static const Locale english = Locale('en');
  static const Locale french = Locale('fr');
  static const Locale spanish = Locale('es');
  static const Locale german = Locale('de');
  static const Locale italian = Locale('it');
  static const Locale portuguese = Locale('pt');
  static const Locale russian = Locale('ru');
  static const Locale dutch = Locale('nl');
  static const Locale swedish = Locale('sv');
  static const Locale norwegian = Locale('no');
  static const Locale danish = Locale('da');
  static const Locale finnish = Locale('fi');
  static const Locale polish = Locale('pl');
  static const Locale czech = Locale('cs');
  static const Locale slovak = Locale('sk');
  static const Locale hungarian = Locale('hu');
  static const Locale romanian = Locale('ro');
  static const Locale bulgarian = Locale('bg');
  static const Locale croatian = Locale('hr');
  static const Locale serbian = Locale('sr');
  static const Locale slovenian = Locale('sl');
  static const Locale lithuanian = Locale('lt');
  static const Locale latvian = Locale('lv');
  static const Locale estonian = Locale('et');
  static const Locale greek = Locale('el');
  static const Locale turkish = Locale('tr');
  static const Locale ukrainian = Locale('uk');
  static const Locale belarusian = Locale('be');

  // Asian Languages
  static const Locale chinese = Locale('zh');
  static const Locale chineseSimplified = Locale('zh', 'CN');
  static const Locale chineseTraditional = Locale('zh', 'TW');
  static const Locale japanese = Locale('ja');
  static const Locale korean = Locale('ko');
  static const Locale thai = Locale('th');
  static const Locale vietnamese = Locale('vi');
  static const Locale indonesian = Locale('id');
  static const Locale malay = Locale('ms');
  static const Locale tagalog = Locale('tl');
  static const Locale burmese = Locale('my');
  static const Locale khmer = Locale('km');
  static const Locale lao = Locale('lo');
  static const Locale mongolian = Locale('mn');

  // Indian Subcontinent Languages
  static const Locale hindi = Locale('hi');
  static const Locale bengali = Locale('bn');
  static const Locale tamil = Locale('ta');
  static const Locale telugu = Locale('te');
  static const Locale marathi = Locale('mr');
  static const Locale gujarati = Locale('gu');
  static const Locale kannada = Locale('kn');
  static const Locale malayalam = Locale('ml');
  static const Locale punjabi = Locale('pa');
  static const Locale urdu = Locale('ur');
  static const Locale nepali = Locale('ne');
  static const Locale sinhala = Locale('si');

  // Middle Eastern & African Languages
  static const Locale arabic = Locale('ar');
  static const Locale hebrew = Locale('he');
  static const Locale persian = Locale('fa');
  static const Locale kurdish = Locale('ku');
  static const Locale amharic = Locale('am');
  static const Locale swahili = Locale('sw');
  static const Locale hausa = Locale('ha');
  static const Locale yoruba = Locale('yo');
  static const Locale igbo = Locale('ig');
  static const Locale zulu = Locale('zu');
  static const Locale afrikaans = Locale('af');

  // Other Languages
  static const Locale albanian = Locale('sq');
  static const Locale armenian = Locale('hy');
  static const Locale azerbaijani = Locale('az');
  static const Locale basque = Locale('eu');
  static const Locale bosnian = Locale('bs');
  static const Locale catalan = Locale('ca');
  static const Locale georgian = Locale('ka');
  static const Locale icelandic = Locale('is');
  static const Locale kazakh = Locale('kk');
  static const Locale kyrgyz = Locale('ky');
  static const Locale macedonian = Locale('mk');
  static const Locale maltese = Locale('mt');
  static const Locale uzbek = Locale('uz');
  static const Locale welsh = Locale('cy');
  static const Locale irish = Locale('ga');
  static const Locale scots = Locale('gd');

  /// Initializes QuikLocale with the provided configuration.
  ///
  /// This method must be called before using any other QuikLocale functionality,
  /// typically in your app's main() function.
  ///
  /// Example:
  /// ```dart
  /// await QuikLocale.init(LocaleConfig(
  ///   baseLocale: QuikLocale.english,
  ///   supportedLocales: [QuikLocale.english, QuikLocale.french],
  /// ));
  /// ```
  static Future<void> init(LocaleConfig config) async {
    _config = config;
    _currentLocale = config.baseLocale;

    // Try to get the device's preferred locale
    final deviceLocale = _getDeviceLocale();
    if (deviceLocale != null && _isLocaleSupported(deviceLocale)) {
      _currentLocale = deviceLocale;
    }
  }

  /// Gets the current active locale.
  ///
  /// Returns the currently active locale, or the base locale if not initialized.
  static Locale get getLocale {
    _ensureInitialized();
    return _currentLocale ?? _config!.baseLocale;
  }

  /// Gets the list of supported locales.
  ///
  /// Returns the list of supported locales from the configuration.
  static List<Locale> get getSupportedLocales {
    _ensureInitialized();
    return _config!.supportedLocales;
  }

  /// Gets the localization delegates for MaterialApp.
  ///
  /// Returns the Flutter localization delegates including support for multiple languages.
  static List<LocalizationsDelegate<dynamic>> get localizationDelegates {
    return const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
  }

  /// Sets the current locale and notifies all listeners.
  ///
  /// [localeCode] can be a language code ('en') or language_country code ('en_US').
  ///
  /// Example:
  /// ```dart
  /// QuikLocale.setLocale('fr'); // Switch to French
  /// QuikLocale.setLocale('en_US'); // Switch to US English
  /// ```
  static void setLocale(String localeCode) {
    _ensureInitialized();

    final newLocale = LocaleConfig.localeFromCode(localeCode);
    if (_isLocaleSupported(newLocale)) {
      _currentLocale = newLocale;
      _notifyListeners();
    } else {
      throw ArgumentError('Locale $localeCode is not supported');
    }
  }

  /// Translates a [QuikLocaleString] to the current locale.
  ///
  /// [localeString] is the QuikLocaleString to translate.
  /// [params] is an optional map of parameters to substitute in the translation.
  ///
  /// Returns the translated string with parameters substituted.
  static String translate(QuikLocaleString localeString, {Map<String, dynamic>? params}) {
    _ensureInitialized();

    final localeCode = LocaleConfig.getLocaleCode(_currentLocale!);
    String translation = localeString.getTranslation(localeCode);

    // Substitute parameters if provided
    if (params != null) {
      translation = _substituteParameters(translation, params);
    }

    return translation;
  }

  /// Translates a [QuikLocaleString] with plural support.
  ///
  /// [localeString] is the QuikLocaleString to translate.
  /// [count] is the number used to determine the plural form.
  /// [params] is an optional map of parameters to substitute in the translation.
  ///
  /// Returns the translated string in the appropriate plural form.
  static String translatePlural(QuikLocaleString localeString, int count, {Map<String, dynamic>? params}) {
    _ensureInitialized();

    final localeCode = LocaleConfig.getLocaleCode(_currentLocale!);
    String translation = localeString.getPluralTranslation(localeCode, count);

    // Add count to params if not already present
    final allParams = Map<String, dynamic>.from(params ?? {});
    allParams.putIfAbsent('count', () => count);

    // Substitute parameters
    translation = _substituteParameters(translation, allParams);

    return translation;
  }

  /// Adds a listener that will be called when the locale changes.
  ///
  /// The listener will be called whenever [setLocale] is called.
  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Removes a previously added listener.
  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Gets the current locale code as a string.
  ///
  /// Returns the current locale code (e.g., 'en', 'fr', 'en_US').
  static String get currentLocaleCode {
    _ensureInitialized();
    return LocaleConfig.getLocaleCode(_currentLocale!);
  }

  /// Resets QuikLocale to uninitialized state (primarily for testing).
  ///
  /// This method clears the configuration and current locale, returning
  /// QuikLocale to its initial uninitialized state.
  @visibleForTesting
  static void reset() {
    _config = null;
    _currentLocale = null;
    _listeners.clear();
  }

  /// Checks if a locale is supported.
  static bool _isLocaleSupported(Locale locale) {
    return _config!.supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode);
  }

  /// Gets the device's preferred locale.
  static Locale? _getDeviceLocale() {
    try {
      // Use PlatformDispatcher instead of deprecated window
      return PlatformDispatcher.instance.locale;
    } catch (e) {
      return null;
    }
  }

  /// Ensures that QuikLocale has been initialized.
  static void _ensureInitialized() {
    if (_config == null) {
      throw StateError('QuikLocale not initialized. Call QuikLocale.init() first.');
    }
  }

  /// Notifies all listeners about locale changes.
  static void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Substitutes parameters in a translation string.
  ///
  /// Replaces placeholders like {name} with actual values from the params map.
  static String _substituteParameters(String text, Map<String, dynamic> params) {
    String result = text;

    for (final entry in params.entries) {
      final placeholder = '{${entry.key}}';
      result = result.replaceAll(placeholder, entry.value.toString());
    }

    return result;
  }
}
