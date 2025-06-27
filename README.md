# QuikLocale

Manual, typed, effortless Flutter localization. Define translations as Dart constants with full IDE support and type safety.

## Features

- 🚫 **No code generation** - Define translations directly in Dart code
- 🔒 **Type safe** - Full IDE autocomplete and compile-time checks  
- 🎯 **Manual control** - You define every translation key and value
- 📝 **Parameter support** - Use `{param}` syntax for dynamic values
- 🔢 **Pluralization** - Basic plural form support
- 🔄 **Runtime locale switching** - Change locale and update UI instantly
- ⚡ **Simple integration** - Easy MaterialApp setup
- 🌍 **72 built-in locales** - Extensive language support with regional variants

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  quik_locale: ^1.0.0
```

## Quick Start

### 1. Initialize QuikLocale

In your `main()` function:

```dart
import 'package:quik_locale/quik_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await QuikLocale.init(LocaleConfig(
    baseLocale: QuikLocale.english,   // Fallback locale
    supportedLocales: [
      QuikLocale.english,
      QuikLocale.french,
      QuikLocale.spanish,
    ],
  ));
  
  runApp(MyApp());
}
```

### 2. Set up MaterialApp

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: QuikLocale.getLocale,
      supportedLocales: QuikLocale.getSupportedLocales,
      localizationsDelegates: QuikLocale.localizationDelegates,
      home: MyHomePage(),
    );
  }
}
```

### 3. Define Translation Keys

Create your own locale key classes using `QuikLocaleString`:

```dart
class AppLocale {
  static const helloWorld = QuikLocaleString(
    base: "Hello World",
    translations: {
      "fr": "Bonjour le monde",
      "es": "Hola Mundo",
    },
  );

  static const welcome = QuikLocaleString(
    base: "Welcome, {name}!",
    translations: {
      "fr": "Bienvenue, {name} !",
      "es": "¡Bienvenido, {name}!",
    },
  );

  static const itemCount = QuikLocaleString(
    base: "You have {count} items",
    translations: {
      "en_one": "You have {count} item",
      "en_other": "You have {count} items",
      "fr_one": "Vous avez {count} élément", 
      "fr_other": "Vous avez {count} éléments",
    },
  );
}
```

### 4. Use Translations in Widgets

```dart
// Simple translation
Text(AppLocale.helloWorld.tr())

// With parameters
Text(AppLocale.welcome.tr(params: {'name': 'John'}))

// With pluralization
Text(AppLocale.itemCount.trPlural(5))
```

## Supported Languages

QuikLocale provides built-in support for 72 languages with their associated locale codes:

| Region | Language | Locale Code |
|--------|----------|------------|
| **European Languages** | | |
| | English | en |
| | French | fr |
| | Spanish | es |
| | German | de |
| | Italian | it |
| | Portuguese | pt |
| | Russian | ru |
| | Dutch | nl |
| | Swedish | sv |
| | Norwegian | no |
| | Danish | da |
| | Finnish | fi |
| | Polish | pl |
| | Czech | cs |
| | Slovak | sk |
| | Hungarian | hu |
| | Romanian | ro |
| | Bulgarian | bg |
| | Croatian | hr |
| | Serbian | sr |
| | Slovenian | sl |
| | Lithuanian | lt |
| | Latvian | lv |
| | Estonian | et |
| | Greek | el |
| | Turkish | tr |
| | Ukrainian | uk |
| | Belarusian | be |
| **Asian Languages** | | |
| | Chinese | zh |
| | Chinese (Simplified) | zh_CN |
| | Chinese (Traditional) | zh_TW |
| | Japanese | ja |
| | Korean | ko |
| | Thai | th |
| | Vietnamese | vi |
| | Indonesian | id |
| | Malay | ms |
| | Tagalog | tl |
| | Burmese | my |
| | Khmer | km |
| | Lao | lo |
| | Mongolian | mn |
| **Indian Subcontinent** | | |
| | Hindi | hi |
| | Bengali | bn |
| | Tamil | ta |
| | Telugu | te |
| | Marathi | mr |
| | Gujarati | gu |
| | Kannada | kn |
| | Malayalam | ml |
| | Punjabi | pa |
| | Urdu | ur |
| | Nepali | ne |
| | Sinhala | si |
| **Middle Eastern & African** | | |
| | Arabic | ar |
| | Hebrew | he |
| | Persian | fa |
| | Kurdish | ku |
| | Amharic | am |
| | Swahili | sw |
| | Hausa | ha |
| | Yoruba | yo |
| | Igbo | ig |
| | Zulu | zu |
| | Afrikaans | af |
| **Other Languages** | | |
| | Albanian | sq |
| | Armenian | hy |
| | Azerbaijani | az |
| | Basque | eu |
| | Bosnian | bs |
| | Catalan | ca |
| | Georgian | ka |
| | Icelandic | is |
| | Kazakh | kk |
| | Kyrgyz | ky |
| | Macedonian | mk |
| | Maltese | mt |
| | Uzbek | uz |
| | Welsh | cy |
| | Irish | ga |
| | Scots | gd |

## Usage Examples

### Change Locale at Runtime

```dart
// Switch to French
QuikLocale.setLocale('fr');

// Switch to Traditional Chinese
QuikLocale.setLocale('zh_TW');
```

### Listen for Locale Changes

```dart
@override
void initState() {
  super.initState();
  QuikLocale.addListener(_onLocaleChanged);
}

@override
void dispose() {
  QuikLocale.removeListener(_onLocaleChanged);
  super.dispose();
}

void _onLocaleChanged() {
  setState(() {
    // Update UI when locale changes
  });
}
```

## Advanced Use Cases

### Using Default Parameters

```dart
static const greeting = QuikLocaleString(
  base: "Good {timeOfDay}, {name}!",
  translations: {
    "fr": "Bon{timeOfDay}, {name} !",
    "es": "¡Buen{timeOfDay}, {name}!",
  },
);

// Usage with default params
Text(AppLocale.greeting.tr(params: {
  'timeOfDay': ' evening',
  'name': 'Alice'
}))
```

### Custom Locale Selection Logic

You can implement custom locale selection logic by extending the `LocaleConfig` class and overriding the locale resolution method.
