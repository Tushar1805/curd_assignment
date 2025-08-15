// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get selectLanguage => 'Select Your Language';

  @override
  String get selectLanguageDesc =>
      'Your selected language can be changed\nanytime from Settings.';

  @override
  String get continueString => 'Continue';

  @override
  String get somethingWentWrongString => 'Something went wrong';

  @override
  String get skipString => 'Skip';

  @override
  String get onboarding1Title => 'Welcome!';
}
