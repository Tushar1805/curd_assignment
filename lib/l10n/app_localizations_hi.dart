// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get selectLanguage => 'अपनी भाषा का चयन करें';

  @override
  String get selectLanguageDesc =>
      'आपकी चयनित भाषा को सेटिंग्स से किसी भी \nसमय बदला जा सकता है।';

  @override
  String get continueString => 'जारी रखें';

  @override
  String get somethingWentWrongString => 'कुछ गलत हो गया';

  @override
  String get skipString => 'छोड़ें';

  @override
  String get onboarding1Title => 'स्वागत है!';
}
