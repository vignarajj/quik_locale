# Changelog

## [1.0.0] - 2025-06-27

### Added
- Initial release of QuikLocale Flutter localization plugin
- Manual translation key definition using `QuikLocaleString` class
- Type-safe translation with full IDE support and autocomplete
- Runtime locale switching with `QuikLocale.setLocale()`
- Parameter support using `{param}` syntax in translations
- Basic pluralization support with locale-specific plural forms
- 18 built-in locale constants (English, French, Spanish, German, etc.)
- Extension methods `.tr()` and `.plural()` for easy usage
- Locale change listeners for reactive UI updates
- MaterialApp integration with provided delegates
- Comprehensive documentation and examples
- Unit tests covering all major features
- Complete example Flutter app demonstrating all functionality

### Features
- No code generation required
- No external files (JSON, ARB, etc.)
- Full type safety and compile-time checks
- Simple initialization with `LocaleConfig`
- Automatic device locale detection
- Fallback to base locale for missing translations
- Support for complex parameter substitution
- Listener pattern for locale change notifications
