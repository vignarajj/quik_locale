import 'package:flutter/material.dart';
import 'package:quik_locale/quik_locale.dart';

// Define your translation keys using QuikLocaleString
class AppLocale {
  static const appTitle = QuikLocaleString(
    base: "QuikLocale Demo",
    translations: {
      "fr": "Démo QuikLocale",
      "es": "Demo QuikLocale",
      "de": "QuikLocale Demo",
    },
  );

  static const welcomeMessage = QuikLocaleString(
    base: "Welcome to QuikLocale!",
    translations: {
      "fr": "Bienvenue dans QuikLocale !",
      "es": "¡Bienvenido a QuikLocale!",
      "de": "Willkommen bei QuikLocale!",
    },
  );

  static const personalizedGreeting = QuikLocaleString(
    base: "Hello, {name}! How are you today?",
    translations: {
      "fr": "Bonjour, {name} ! Comment allez-vous aujourd'hui ?",
      "es": "¡Hola, {name}! ¿Cómo estás hoy?",
      "de": "Hallo, {name}! Wie geht es dir heute?",
    },
  );

  static const itemCount = QuikLocaleString(
    base: "You have {count} items",
    translations: {
      "en_one": "You have {count} item",
      "en_other": "You have {count} items",
      "fr_one": "Vous avez {count} élément",
      "fr_other": "Vous avez {count} éléments",
      "es_one": "Tienes {count} elemento",
      "es_other": "Tienes {count} elementos",
      "de_one": "Sie haben {count} Element",
      "de_other": "Sie haben {count} Elemente",
    },
  );

  static const changeLanguage = QuikLocaleString(
    base: "Change Language",
    translations: {
      "fr": "Changer de langue",
      "es": "Cambiar idioma",
      "de": "Sprache ändern",
    },
  );

  static const currentLanguage = QuikLocaleString(
    base: "Current Language: {language}",
    translations: {
      "fr": "Langue actuelle : {language}",
      "es": "Idioma actual: {language}",
      "de": "Aktuelle Sprache: {language}",
    },
  );

  static const addItem = QuikLocaleString(
    base: "Add Item",
    translations: {
      "fr": "Ajouter un élément",
      "es": "Agregar elemento",
      "de": "Element hinzufügen",
    },
  );

  static const removeItem = QuikLocaleString(
    base: "Remove Item",
    translations: {
      "fr": "Supprimer un élément",
      "es": "Eliminar elemento",
      "de": "Element entfernen",
    },
  );

  static const noItems = QuikLocaleString(
    base: "No items yet",
    translations: {
      "fr": "Aucun élément pour le moment",
      "es": "No hay elementos aún",
      "de": "Noch keine Elemente",
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize QuikLocale
  await QuikLocale.init(LocaleConfig(
    baseLocale: QuikLocale.english,
    supportedLocales: [
      QuikLocale.english,
      QuikLocale.french,
      QuikLocale.spanish,
      QuikLocale.german,
    ],
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Listen for locale changes to rebuild the app
    QuikLocale.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    QuikLocale.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {
      // Rebuild the app when locale changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocale.appTitle.tr(),
      locale: QuikLocale.getLocale,
      supportedLocales: QuikLocale.getSupportedLocales,
      localizationsDelegates: QuikLocale.localizationDelegates,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _itemCount = 0;
  final String _userName = "John Doe";

  void _addItem() {
    setState(() {
      _itemCount++;
    });
  }

  void _removeItem() {
    setState(() {
      if (_itemCount > 0) _itemCount--;
    });
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocale.changeLanguage.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English', 'en'),
              _buildLanguageOption('Français', 'fr'),
              _buildLanguageOption('Español', 'es'),
              _buildLanguageOption('Deutsch', 'de'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String languageName, String localeCode) {
    return ListTile(
      title: Text(languageName),
      trailing: QuikLocale.currentLocaleCode == localeCode
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        QuikLocale.setLocale(localeCode);
        Navigator.of(context).pop();
      },
    );
  }

  String _getLanguageName(String localeCode) {
    switch (localeCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'de':
        return 'Deutsch';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.appTitle.tr()),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: _showLanguageDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.welcomeMessage.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocale.personalizedGreeting.tr(params: {'name': _userName}),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Current language display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocale.currentLanguage.tr(params: {
                    'language': _getLanguageName(QuikLocale.currentLocaleCode),
                  }),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Item counter with pluralization
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _itemCount == 0
                          ? AppLocale.noItems.tr()
                          : AppLocale.itemCount.plural(_itemCount),
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add),
                          label: Text(AppLocale.addItem.tr()),
                        ),
                        ElevatedButton.icon(
                          onPressed: _itemCount > 0 ? _removeItem : null,
                          icon: const Icon(Icons.remove),
                          label: Text(AppLocale.removeItem.tr()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Language selection button
            ElevatedButton.icon(
              onPressed: _showLanguageDialog,
              icon: const Icon(Icons.language),
              label: Text(AppLocale.changeLanguage.tr()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
