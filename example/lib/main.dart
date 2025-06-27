import 'package:flutter/material.dart';
import 'package:quik_locale/quik_locale.dart';
import 'locale_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize QuikLocale with supported locales
  await QuikLocale.init(LocaleConfig(
    baseLocale: QuikLocale.english,
    supportedLocales: [
      QuikLocale.english,
      QuikLocale.french,
      QuikLocale.spanish,
      QuikLocale.german,
      QuikLocale.tamil,
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
      localizationsDelegates: [
        ...QuikLocale.localizationDelegates,
      ],
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
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocale.personalizedGreeting.tr(params: {'name': _userName}),
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
                        AppLocale.currentLanguage.tr(params: {
                          'language': _getLanguageName(QuikLocale.currentLocaleCode),
                        }),
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
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                        AppLocale.todayIs.tr(params: {
                          'day': DateTime.now().day,
                          'month': _getMonthName(DateTime.now().month),
                          'year': DateTime.now().year,
                        }),
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
                      Icon(Icons.language, size: 28, color: Colors.blue.shade600),
                      const SizedBox(width: 12),
                      Text(
                        AppLocale.changeLanguage.tr(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    ...AppLocale.featuresList.map((feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle,
                               color: Colors.green,
                               size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(feature.tr())),
                        ],
                      ),
                    )),
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
