/// QuikLocale - Manual, Typed, Effortless Localization
///
/// A Flutter localization plugin that allows you to define translations as
/// static Dart constants with full IDE support and type safety.
///
/// ## Features
///
/// - **No code generation**: Define translations directly in Dart code
/// - **Type safe**: Full IDE autocomplete and compile-time checks
/// - **Manual control**: You define every translation key and value
/// - **Parameter support**: Use {param} syntax for dynamic values
/// - **Pluralization**: Basic plural form support
/// - **Runtime locale switching**: Change locale and update UI instantly
/// - **Simple integration**: Easy MaterialApp setup
/// - **72 built-in locales**: Extensive language support covering major world languages
///
/// ## Quick Start
///
/// 1. Initialize QuikLocale in your main function:
/// ```dart
/// await QuikLocale.init(LocaleConfig(
///   baseLocale: QuikLocale.english,
///   supportedLocales: [QuikLocale.english, QuikLocale.french],
/// ));
/// ```
///
/// 2. Set up MaterialApp:
/// ```dart
/// MaterialApp(
///   locale: QuikLocale.getLocale,
///   supportedLocales: QuikLocale.getSupportedLocales,
///   localizationsDelegates: QuikLocale.localizationDelegates,
///   // ...
/// )
/// ```
///
/// 3. Define your translation keys:
/// ```dart
/// class AppLocale {
///   static const helloWorld = QuikLocaleString(
///     base: "Hello World",
///     translations: {
///       "fr": "Bonjour le monde",
///       "es": "Hola Mundo",
///     },
///   );
/// }
/// ```
///
/// 4. Use translations in widgets:
/// ```dart
/// Text(AppLocale.helloWorld.tr())
/// Text(AppLocale.welcome.tr(params: {'name': 'John'}))
/// Text(AppLocale.itemCount.trPlural(5))
/// ```
///
/// 5. Change locale at runtime:
/// ```dart
/// QuikLocale.setLocale('fr');
/// ```
///
library quik_locale;

export 'src/quik_locale_base.dart';
export 'src/quik_locale_string.dart';
export 'src/locale_config.dart';
export 'src/extensions.dart';
