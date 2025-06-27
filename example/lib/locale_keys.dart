import 'package:quik_locale/quik_locale.dart';

/// Application locale keys organized by feature/screen.
/// This demonstrates best practices for organizing translation keys.
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
    base: "This app demonstrates all QuikLocale features including parameters, pluralization, and runtime locale switching.",
    translations: {
      "fr": "Cette application démontre toutes les fonctionnalités de QuikLocale, y compris les paramètres, la pluralisation et le changement de langue en temps réel.",
      "es": "Esta aplicación demuestra todas las características de QuikLocale, incluyendo parámetros, pluralización y cambio de idioma en tiempo real.",
      "de": "Diese App demonstriert alle QuikLocale-Features einschließlich Parameter, Pluralisierung und Laufzeit-Sprachwechsel.",
      "ta": "இந்த செயலி QuikLocale இன் அனைத்து அம்சங்களையும் காட்டுகிறது, அதில் அளவுருக்கள், பன்மை வடிவங்கள் மற்றும் இயக்க நேர மொழி மாற்றம் அடங்கும்.",
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
    translations: {
      "fr": "Mars",
      "es": "Marzo",
      "de": "März",
      "ta": "மார்ச்",
    },
  );

  static const april = QuikLocaleString(
    base: "April",
    translations: {
      "fr": "Avril",
      "es": "Abril",
      "de": "April",
      "ta": "ஏப்ரல்",
    },
  );

  static const may = QuikLocaleString(
    base: "May",
    translations: {
      "fr": "Mai",
      "es": "Mayo",
      "de": "Mai",
      "ta": "மே",
    },
  );

  static const june = QuikLocaleString(
    base: "June",
    translations: {
      "fr": "Juin",
      "es": "Junio",
      "de": "Juni",
      "ta": "ஜூன்",
    },
  );

  static const july = QuikLocaleString(
    base: "July",
    translations: {
      "fr": "Juillet",
      "es": "Julio",
      "de": "Juli",
      "ta": "ஜூலை",
    },
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
