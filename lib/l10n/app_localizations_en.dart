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

  @override
  String get productsString => 'Products';

  @override
  String get changeLanguageString => 'Change Language';

  @override
  String get settingsString => 'Settings';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get addToCartString => 'Add to Cart';

  @override
  String get addedToCartString => 'Added to Cart';

  @override
  String get categoryString => 'Category';

  @override
  String get cartString => 'cart';

  @override
  String get noItemsString => 'No Items';

  @override
  String get totalString => 'Total';

  @override
  String get checkoutString => 'Checkout';

  @override
  String get retryString => 'Retry';
}
