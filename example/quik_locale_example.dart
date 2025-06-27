import 'package:flutter/material.dart';
import 'package:quik_locale/quik_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize QuikLocale with supported locales
  await QuikLocale.init(
    LocaleConfig(
      baseLocale: QuikLocale.english,
      supportedLocales: [
        QuikLocale.english,
        QuikLocale.french,
        QuikLocale.spanish,
        QuikLocale.german,
        QuikLocale.tamil,
      ],
    ),
  );

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
      localizationsDelegates: [...QuikLocale.localizationDelegates],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              _buildLanguageOption('தமிழ்', 'ta'),
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
      case 'ta':
        return 'தமிழ்';
      default:
        return 'Unknown';
    }
  }

  String _getItemCountText() {
    if (_itemCount == 0) {
      return AppLocale.noItems.tr();
    } else {
      return AppLocale.itemCount.plural(_itemCount);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.welcomeMessage.tr(),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocale.personalizedGreeting.tr(
                        params: {'name': _userName},
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocale.featureDescription.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Current language display
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.language, color: Colors.blue.shade600),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppLocale.currentLanguage.tr(
                          params: {
                            'language': _getLanguageName(
                              QuikLocale.currentLocaleCode,
                            ),
                          },
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Item counter with pluralization demo
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      AppLocale.pluralizationDemo.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getItemCountText(),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _addItem,
                            icon: const Icon(Icons.add),
                            label: Text(AppLocale.addItem.tr()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _itemCount > 0 ? _removeItem : null,
                            icon: const Icon(Icons.remove),
                            label: Text(AppLocale.removeItem.tr()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Parameter substitution demo
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.parameterDemo.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        AppLocale.todayIs.tr(
                          params: {
                            'day': DateTime.now().day,
                            'month': _getMonthName(DateTime.now().month),
                            'year': DateTime.now().year,
                          },
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Language selection button
            Card(
              elevation: 4,
              child: InkWell(
                onTap: _showLanguageDialog,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        size: 28,
                        color: Colors.blue.shade600,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppLocale.changeLanguage.tr(),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Features showcase
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.featuresTitle.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...AppLocale.featuresList.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(feature.tr())),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final months = [
      AppLocale.january.tr(),
      AppLocale.february.tr(),
      AppLocale.march.tr(),
      AppLocale.april.tr(),
      AppLocale.may.tr(),
      AppLocale.june.tr(),
      AppLocale.july.tr(),
      AppLocale.august.tr(),
      AppLocale.september.tr(),
      AppLocale.october.tr(),
      AppLocale.november.tr(),
      AppLocale.december.tr(),
    ];
    return months[month - 1];
  }
}

class AppLocale {
  // App basics
  static const appTitle = QuikLocaleString(
    base: "QuikLocale Demo",
    translations: {
      "fr": "Démo QuikLocale",
      "es": "Demo QuikLocale",
      "de": "QuikLocale Demo",
      "ta": "QuikLocale டெமோ",
    },
  );

  static const welcomeMessage = QuikLocaleString(
    base: "Welcome to QuikLocale!",
    translations: {
      "fr": "Bienvenue dans QuikLocale !",
      "es": "¡Bienvenido a QuikLocale!",
      "de": "Willkommen bei QuikLocale!",
      "ta": "QuikLocale இல் வரவேற்கிறோம்!",
    },
  );

  static const personalizedGreeting = QuikLocaleString(
    base: "Hello, {name}! How are you today?",
    translations: {
      "fr": "Bonjour, {name} ! Comment allez-vous aujourd'hui ?",
      "es": "¡Hola, {name}! ¿Cómo estás hoy?",
      "de": "Hallo, {name}! Wie geht es dir heute?",
      "ta": "வணக்கம், {name}! இன்று எப்படி இருக்கிறீர்கள்?",
    },
  );

  static const featureDescription = QuikLocaleString(
    base:
        "This app demonstrates all QuikLocale features including parameters, pluralization, and runtime locale switching.",
    translations: {
      "fr":
          "Cette application démontre toutes les fonctionnalités de QuikLocale, y compris les paramètres, la pluralisation et le changement de langue en temps réel.",
      "es":
          "Esta aplicación demuestra todas las características de QuikLocale, incluyendo parámetros, pluralización y cambio de idioma en tiempo real.",
      "de":
          "Diese App demonstriert alle QuikLocale-Features einschließlich Parameter, Pluralisierung und Laufzeit-Sprachwechsel.",
      "ta":
          "இந்த செயலி QuikLocale இன் அனைத்து அம்சங்களையும் காட்டுகிறது, அதில் அளவுருக்கள், பன்மை வடிவங்கள் மற்றும் இயக்க நேர மொழி மாற்றம் அடங்கும்.",
    },
  );

  // Language settings
  static const changeLanguage = QuikLocaleString(
    base: "Change Language",
    translations: {
      "fr": "Changer de langue",
      "es": "Cambiar idioma",
      "de": "Sprache ändern",
      "ta": "மொழியை மாற்று",
    },
  );

  static const currentLanguage = QuikLocaleString(
    base: "Current Language: {language}",
    translations: {
      "fr": "Langue actuelle : {language}",
      "es": "Idioma actual: {language}",
      "de": "Aktuelle Sprache: {language}",
      "ta": "தற்போதைய மொழி: {language}",
    },
  );

  // Pluralization demo
  static const pluralizationDemo = QuikLocaleString(
    base: "Pluralization Demo",
    translations: {
      "fr": "Démonstration de pluralisation",
      "es": "Demostración de pluralización",
      "de": "Pluralisierungs-Demo",
      "ta": "பன்மை வடிவ செயல்பாடு",
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
      "ta_one": "உங்களிடம் {count} பொருள் உள்ளது",
      "ta_other": "உங்களிடம் {count} பொருட்கள் உள்ளன",
    },
  );

  static const noItems = QuikLocaleString(
    base: "No items yet",
    translations: {
      "fr": "Aucun élément pour le moment",
      "es": "No hay elementos aún",
      "de": "Noch keine Elemente",
      "ta": "இன்னும் பொருட்கள் இல்லை",
    },
  );

  static const addItem = QuikLocaleString(
    base: "Add Item",
    translations: {
      "fr": "Ajouter un élément",
      "es": "Agregar elemento",
      "de": "Element hinzufügen",
      "ta": "பொருள் சேர்",
    },
  );

  static const removeItem = QuikLocaleString(
    base: "Remove Item",
    translations: {
      "fr": "Supprimer un élément",
      "es": "Eliminar elemento",
      "de": "Element entfernen",
      "ta": "பொருள் நீக்கு",
    },
  );

  // Parameter demo
  static const parameterDemo = QuikLocaleString(
    base: "Parameter Substitution Demo",
    translations: {
      "fr": "Démonstration de substitution de paramètres",
      "es": "Demostración de sustitución de parámetros",
      "de": "Parameter-Substitutions-Demo",
      "ta": "அளவுரு மாற்று செயல்பாடு",
    },
  );

  static const todayIs = QuikLocaleString(
    base: "Today is {day} {month}, {year}",
    translations: {
      "fr": "Aujourd'hui, c'est le {day} {month} {year}",
      "es": "Hoy es {day} de {month} de {year}",
      "de": "Heute ist der {day}. {month} {year}",
      "ta": "இன்று {day} {month}, {year}",
    },
  );

  // Features showcase
  static const featuresTitle = QuikLocaleString(
    base: "QuikLocale Features",
    translations: {
      "fr": "Fonctionnalités de QuikLocale",
      "es": "Características de QuikLocale",
      "de": "QuikLocale-Features",
      "ta": "QuikLocale அம்சங்கள்",
    },
  );

  static const List<QuikLocaleString> featuresList = [
    QuikLocaleString(
      base: "No code generation required",
      translations: {
        "fr": "Aucune génération de code requise",
        "es": "No se requiere generación de código",
        "de": "Keine Code-Generierung erforderlich",
        "ta": "குறியீடு உருவாக்கம் தேவையில்லை",
      },
    ),
    QuikLocaleString(
      base: "Type-safe with full IDE support",
      translations: {
        "fr": "Type-safe avec support IDE complet",
        "es": "Tipo seguro con soporte completo del IDE",
        "de": "Typsicher mit vollständiger IDE-Unterstützung",
        "ta": "முழு IDE ஆதரவுடன் வகை-பாதுகாப்பு",
      },
    ),
    QuikLocaleString(
      base: "Runtime locale switching",
      translations: {
        "fr": "Changement de langue en temps réel",
        "es": "Cambio de idioma en tiempo de ejecución",
        "de": "Sprachwechsel zur Laufzeit",
        "ta": "இயக்க நேர மொழி மாற்றம்",
      },
    ),
    QuikLocaleString(
      base: "Parameter and plural support",
      translations: {
        "fr": "Support des paramètres et pluriels",
        "es": "Soporte de parámetros y plurales",
        "de": "Parameter- und Plural-Unterstützung",
        "ta": "அளவுரு மற்றும் பன்மை ஆதரவு",
      },
    ),
    QuikLocaleString(
      base: "Easy MaterialApp integration",
      translations: {
        "fr": "Intégration facile avec MaterialApp",
        "es": "Fácil integración con MaterialApp",
        "de": "Einfache MaterialApp-Integration",
        "ta": "எளிய MaterialApp ஒருங்கிணைப்பு",
      },
    ),
  ];

  // Month names for date demo
  static const january = QuikLocaleString(
    base: "January",
    translations: {
      "fr": "Janvier",
      "es": "Enero",
      "de": "Januar",
      "ta": "ஜனவரி",
    },
  );

  static const february = QuikLocaleString(
    base: "February",
    translations: {
      "fr": "Février",
      "es": "Febrero",
      "de": "Februar",
      "ta": "பிப்ரவரி",
    },
  );

  static const march = QuikLocaleString(
    base: "March",
    translations: {"fr": "Mars", "es": "Marzo", "de": "März", "ta": "மார்ச்"},
  );

  static const april = QuikLocaleString(
    base: "April",
    translations: {"fr": "Avril", "es": "Abril", "de": "April", "ta": "ஏப்ரல்"},
  );

  static const may = QuikLocaleString(
    base: "May",
    translations: {"fr": "Mai", "es": "Mayo", "de": "Mai", "ta": "மே"},
  );

  static const june = QuikLocaleString(
    base: "June",
    translations: {"fr": "Juin", "es": "Junio", "de": "Juni", "ta": "ஜூன்"},
  );

  static const july = QuikLocaleString(
    base: "July",
    translations: {"fr": "Juillet", "es": "Julio", "de": "Juli", "ta": "ஜூலை"},
  );

  static const august = QuikLocaleString(
    base: "August",
    translations: {
      "fr": "Août",
      "es": "Agosto",
      "de": "August",
      "ta": "ஆகஸ்ட்",
    },
  );

  static const september = QuikLocaleString(
    base: "September",
    translations: {
      "fr": "Septembre",
      "es": "Septiembre",
      "de": "September",
      "ta": "செப்டம்பர்",
    },
  );

  static const october = QuikLocaleString(
    base: "October",
    translations: {
      "fr": "Octobre",
      "es": "Octubre",
      "de": "Oktober",
      "ta": "அக்டோபர்",
    },
  );

  static const november = QuikLocaleString(
    base: "November",
    translations: {
      "fr": "Novembre",
      "es": "Noviembre",
      "de": "November",
      "ta": "நவம்பர்",
    },
  );

  static const december = QuikLocaleString(
    base: "December",
    translations: {
      "fr": "Décembre",
      "es": "Diciembre",
      "de": "Dezember",
      "ta": "டிசம்பர்",
    },
  );
}
