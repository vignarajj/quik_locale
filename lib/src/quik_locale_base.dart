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

  /// Private constructor to prevent instantiation.
  ///
  /// This class is designed to be used via static methods only.
  QuikLocale._();

  // Common locale constants
  // Major European Languages

  /// English locale (en)
  static const Locale english = Locale('en');

  /// French locale (fr)
  static const Locale french = Locale('fr');

  /// Spanish locale (es)
  static const Locale spanish = Locale('es');

  /// German locale (de)
  static const Locale german = Locale('de');

  /// Italian locale (it)
  static const Locale italian = Locale('it');

  /// Portuguese locale (pt)
  static const Locale portuguese = Locale('pt');

  /// Russian locale (ru)
  static const Locale russian = Locale('ru');

  /// Dutch locale (nl)
  static const Locale dutch = Locale('nl');

  /// Swedish locale (sv)
  static const Locale swedish = Locale('sv');

  /// Norwegian locale (no)
  static const Locale norwegian = Locale('no');

  /// Danish locale (da)
  static const Locale danish = Locale('da');

  /// Finnish locale (fi)
  static const Locale finnish = Locale('fi');

  /// Polish locale (pl)
  static const Locale polish = Locale('pl');

  /// Czech locale (cs)
  static const Locale czech = Locale('cs');

  /// Slovak locale (sk)
  static const Locale slovak = Locale('sk');

  /// Hungarian locale (hu)
  static const Locale hungarian = Locale('hu');

  /// Romanian locale (ro)
  static const Locale romanian = Locale('ro');

  /// Bulgarian locale (bg)
  static const Locale bulgarian = Locale('bg');

  /// Croatian locale (hr)
  static const Locale croatian = Locale('hr');

  /// Serbian locale (sr)
  static const Locale serbian = Locale('sr');

  /// Slovenian locale (sl)
  static const Locale slovenian = Locale('sl');

  /// Lithuanian locale (lt)
  static const Locale lithuanian = Locale('lt');

  /// Latvian locale (lv)
  static const Locale latvian = Locale('lv');

  /// Estonian locale (et)
  static const Locale estonian = Locale('et');

  /// Greek locale (el)
  static const Locale greek = Locale('el');

  /// Turkish locale (tr)
  static const Locale turkish = Locale('tr');

  /// Ukrainian locale (uk)
  static const Locale ukrainian = Locale('uk');

  /// Belarusian locale (be)
  static const Locale belarusian = Locale('be');

  // Asian Languages

  /// Chinese locale (zh)
  static const Locale chinese = Locale('zh');

  /// Chinese Simplified locale (zh_CN)
  static const Locale chineseSimplified = Locale('zh', 'CN');

  /// Chinese Traditional locale (zh_TW)
  static const Locale chineseTraditional = Locale('zh', 'TW');

  /// Japanese locale (ja)
  static const Locale japanese = Locale('ja');

  /// Korean locale (ko)
  static const Locale korean = Locale('ko');

  /// Thai locale (th)
  static const Locale thai = Locale('th');

  /// Vietnamese locale (vi)
  static const Locale vietnamese = Locale('vi');

  /// Indonesian locale (id)
  static const Locale indonesian = Locale('id');

  /// Malay locale (ms)
  static const Locale malay = Locale('ms');

  /// Tagalog locale (tl)
  static const Locale tagalog = Locale('tl');

  /// Burmese locale (my)
  static const Locale burmese = Locale('my');

  /// Khmer locale (km)
  static const Locale khmer = Locale('km');

  /// Lao locale (lo)
  static const Locale lao = Locale('lo');

  /// Mongolian locale (mn)
  static const Locale mongolian = Locale('mn');

  // Indian Subcontinent Languages

  /// Hindi locale (hi)
  static const Locale hindi = Locale('hi');

  /// Bengali locale (bn)
  static const Locale bengali = Locale('bn');

  /// Tamil locale (ta)
  static const Locale tamil = Locale('ta');

  /// Telugu locale (te)
  static const Locale telugu = Locale('te');

  /// Marathi locale (mr)
  static const Locale marathi = Locale('mr');

  /// Gujarati locale (gu)
  static const Locale gujarati = Locale('gu');

  /// Kannada locale (kn)
  static const Locale kannada = Locale('kn');

  /// Malayalam locale (ml)
  static const Locale malayalam = Locale('ml');

  /// Punjabi locale (pa)
  static const Locale punjabi = Locale('pa');

  /// Urdu locale (ur)
  static const Locale urdu = Locale('ur');

  /// Nepali locale (ne)
  static const Locale nepali = Locale('ne');

  /// Sinhala locale (si)
  static const Locale sinhala = Locale('si');

  // Middle Eastern & African Languages

  /// Arabic locale (ar)
  static const Locale arabic = Locale('ar');

  /// Hebrew locale (he)
  static const Locale hebrew = Locale('he');

  /// Persian locale (fa)
  static const Locale persian = Locale('fa');

  /// Kurdish locale (ku)
  static const Locale kurdish = Locale('ku');

  /// Amharic locale (am)
  static const Locale amharic = Locale('am');

  /// Swahili locale (sw)
  static const Locale swahili = Locale('sw');

  /// Hausa locale (ha)
  static const Locale hausa = Locale('ha');

  /// Yoruba locale (yo)
  static const Locale yoruba = Locale('yo');

  /// Igbo locale (ig)
  static const Locale igbo = Locale('ig');

  /// Zulu locale (zu)
  static const Locale zulu = Locale('zu');

  /// Afrikaans locale (af)
  static const Locale afrikaans = Locale('af');

  // Other Languages

  /// Albanian locale (sq)
  static const Locale albanian = Locale('sq');

  /// Armenian locale (hy)
  static const Locale armenian = Locale('hy');

  /// Azerbaijani locale (az)
  static const Locale azerbaijani = Locale('az');

  /// Basque locale (eu)
  static const Locale basque = Locale('eu');

  /// Bosnian locale (bs)
  static const Locale bosnian = Locale('bs');

  /// Catalan locale (ca)
  static const Locale catalan = Locale('ca');

  /// Georgian locale (ka)
  static const Locale georgian = Locale('ka');

  /// Icelandic locale (is)
  static const Locale icelandic = Locale('is');

  /// Kazakh locale (kk)
  static const Locale kazakh = Locale('kk');

  /// Kyrgyz locale (ky)
  static const Locale kyrgyz = Locale('ky');

  /// Macedonian locale (mk)
  static const Locale macedonian = Locale('mk');

  /// Maltese locale (mt)
  static const Locale maltese = Locale('mt');

  /// Uzbek locale (uz)
  static const Locale uzbek = Locale('uz');

  /// Welsh locale (cy)
  static const Locale welsh = Locale('cy');

  /// Irish locale (ga)
  static const Locale irish = Locale('ga');

  /// Scots locale (gd)
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
