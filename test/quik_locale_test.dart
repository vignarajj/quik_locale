import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quik_locale/quik_locale.dart';

void main() {
  group('QuikLocale Tests', () {
    setUp(() {
      // Reset QuikLocale state before each test for proper isolation
      QuikLocale.reset();
    });

    group('Initialization', () {
      test('should initialize with valid config', () async {
        final config = LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, QuikLocale.french],
        );

        await QuikLocale.init(config);

        expect(QuikLocale.getLocale, equals(QuikLocale.english));
        expect(QuikLocale.getSupportedLocales, contains(QuikLocale.english));
        expect(QuikLocale.getSupportedLocales, contains(QuikLocale.french));
      });

      test('should throw error when not initialized', () {
        // QuikLocale is reset before this test, so it should throw
        expect(() => QuikLocale.currentLocaleCode, throwsStateError);
      });
    });

    group('Locale Management', () {
      setUp(() async {
        await QuikLocale.init(LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, QuikLocale.french, QuikLocale.spanish],
        ));
      });

      test('should set locale correctly', () {
        QuikLocale.setLocale('fr');
        expect(QuikLocale.currentLocaleCode, equals('fr'));
      });

      test('should throw error for unsupported locale', () {
        expect(() => QuikLocale.setLocale('de'), throwsArgumentError);
      });

      test('should handle locale with country code', () {
        // Add US English to supported locales
        final config = LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, const Locale('en', 'US')],
        );
        QuikLocale.init(config);

        QuikLocale.setLocale('en_US');
        expect(QuikLocale.currentLocaleCode, equals('en_US'));
      });
    });

    group('QuikLocaleString', () {
      late QuikLocaleString testString;

      setUp(() {
        testString = const QuikLocaleString(
          base: "Hello",
          translations: {
            "fr": "Bonjour",
            "es": "Hola",
          },
        );
      });

      test('should return base translation when locale not found', () {
        expect(testString.getTranslation('de'), equals('Hello'));
      });

      test('should return correct translation for supported locale', () {
        expect(testString.getTranslation('fr'), equals('Bonjour'));
        expect(testString.getTranslation('es'), equals('Hola'));
      });
    });

    group('Translation with Parameters', () {
      late QuikLocaleString paramString;

      setUp(() async {
        await QuikLocale.init(LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, QuikLocale.french],
        ));

        paramString = const QuikLocaleString(
          base: "Hello, {name}!",
          translations: {
            "fr": "Bonjour, {name}!",
          },
        );
      });

      test('should substitute parameters correctly', () {
        final result = QuikLocale.translate(paramString, params: {'name': 'John'});
        expect(result, equals('Hello, John!'));
      });

      test('should substitute parameters in translated text', () {
        QuikLocale.setLocale('fr');
        final result = QuikLocale.translate(paramString, params: {'name': 'Jean'});
        expect(result, equals('Bonjour, Jean!'));
      });

      test('should handle multiple parameters', () {
        final multiParamString = const QuikLocaleString(
          base: "Hello, {name}! You have {count} messages.",
          translations: {},
        );

        final result = QuikLocale.translate(
          multiParamString,
          params: {'name': 'Alice', 'count': 5},
        );
        expect(result, equals('Hello, Alice! You have 5 messages.'));
      });
    });

    group('Pluralization', () {
      late QuikLocaleString pluralString;

      setUp(() async {
        await QuikLocale.init(LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, QuikLocale.french],
        ));

        pluralString = const QuikLocaleString(
          base: "{count} item",
          translations: {
            "en_one": "{count} item",
            "en_other": "{count} items",
            "fr_one": "{count} élément",
            "fr_other": "{count} éléments",
          },
        );
      });

      test('should use singular form for count = 1', () {
        final result = QuikLocale.translatePlural(pluralString, 1);
        expect(result, equals('1 item'));
      });

      test('should use plural form for count > 1', () {
        final result = QuikLocale.translatePlural(pluralString, 5);
        expect(result, equals('5 items'));
      });

      test('should use plural form for count = 0', () {
        final result = QuikLocale.translatePlural(pluralString, 0);
        expect(result, equals('0 items'));
      });

      test('should work with French pluralization', () {
        QuikLocale.setLocale('fr');

        final singular = QuikLocale.translatePlural(pluralString, 1);
        expect(singular, equals('1 élément'));

        final plural = QuikLocale.translatePlural(pluralString, 3);
        expect(plural, equals('3 éléments'));
      });
    });

    group('Extensions', () {
      late QuikLocaleString testString;

      setUp(() async {
        await QuikLocale.init(LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, QuikLocale.french],
        ));

        testString = const QuikLocaleString(
          base: "Welcome, {name}!",
          translations: {
            "fr": "Bienvenue, {name}!",
          },
        );
      });

      test('should translate using .tr extension', () {
        final result = testString.tr();
        expect(result, equals('Welcome, {name}!'));
      });

      test('should translate with parameters using .tr extension', () {
        final result = testString.tr(params: {'name': 'Bob'});
        expect(result, equals('Welcome, Bob!'));
      });

      test('should handle plural using .plural extension', () {
        final pluralString = const QuikLocaleString(
          base: "{count} file",
          translations: {
            "en_one": "{count} file",
            "en_other": "{count} files",
          },
        );

        final singular = pluralString.plural(1);
        expect(singular, equals('1 file'));

        final plural = pluralString.plural(3);
        expect(plural, equals('3 files'));
      });
    });

    group('LocaleConfig', () {
      test('should get locale code correctly', () {
        expect(LocaleConfig.getLocaleCode(const Locale('en')), equals('en'));
        expect(LocaleConfig.getLocaleCode(const Locale('en', 'US')), equals('en_US'));
      });

      test('should create locale from code correctly', () {
        final locale1 = LocaleConfig.localeFromCode('en');
        expect(locale1.languageCode, equals('en'));
        expect(locale1.countryCode, isNull);

        final locale2 = LocaleConfig.localeFromCode('en_US');
        expect(locale2.languageCode, equals('en'));
        expect(locale2.countryCode, equals('US'));
      });
    });

    group('Locale Constants', () {
      test('should provide common locale constants', () {
        expect(QuikLocale.english, equals(const Locale('en')));
        expect(QuikLocale.french, equals(const Locale('fr')));
        expect(QuikLocale.spanish, equals(const Locale('es')));
        expect(QuikLocale.german, equals(const Locale('de')));
        expect(QuikLocale.chinese, equals(const Locale('zh')));
        expect(QuikLocale.tamil, equals(const Locale('ta')));
      });
    });

    group('Listeners', () {
      setUp(() async {
        await QuikLocale.init(LocaleConfig(
          baseLocale: QuikLocale.english,
          supportedLocales: [QuikLocale.english, QuikLocale.french],
        ));
      });

      test('should notify listeners on locale change', () {
        bool listenerCalled = false;

        void testListener() {
          listenerCalled = true;
        }

        QuikLocale.addListener(testListener);
        QuikLocale.setLocale('fr');

        expect(listenerCalled, isTrue);

        QuikLocale.removeListener(testListener);
      });

      test('should remove listeners correctly', () {
        bool listenerCalled = false;

        void testListener() {
          listenerCalled = true;
        }

        QuikLocale.addListener(testListener);
        QuikLocale.removeListener(testListener);
        QuikLocale.setLocale('fr');

        expect(listenerCalled, isFalse);
      });
    });
  });
}
