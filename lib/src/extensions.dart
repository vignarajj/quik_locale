import 'quik_locale_base.dart';
import 'quik_locale_string.dart';

/// Extension methods for [QuikLocaleString] to provide convenient translation access.
///
/// These extensions allow you to use `.tr` and `.plural` methods directly on
/// QuikLocaleString instances for easy translation in your widgets.
extension QuikLocaleStringExtension on QuikLocaleString {
  /// Translates this string to the current locale.
  ///
  /// [params] is an optional map of parameters to substitute in the translation.
  ///
  /// Example:
  /// ```dart
  /// Text(DefLocale.helloWorld.tr)
  /// Text(DefLocale.welcome.tr(params: {'name': 'John'}))
  /// ```
  String tr({Map<String, dynamic>? params}) {
    return QuikLocale.translate(this, params: params);
  }

  /// Translates this string with plural support.
  ///
  /// [count] is the number used to determine the plural form.
  /// [params] is an optional map of parameters to substitute in the translation.
  ///
  /// Example:
  /// ```dart
  /// Text(DefLocale.itemCount.plural(items.length))
  /// Text(DefLocale.itemCount.plural(items.length, params: {'type': 'books'}))
  /// ```
  String plural(int count, {Map<String, dynamic>? params}) {
    return QuikLocale.translatePlural(this, count, params: params);
  }
}
