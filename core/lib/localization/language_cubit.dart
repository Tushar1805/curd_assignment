import 'dart:ui';

import 'package:core/di/service_locator.dart';
import 'package:core/utils/core_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curd_assignment/resources/app_keys.dart';
import 'package:curd_assignment/resources/app_storage.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));
  final storage = sl<SecureStorage>();

  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  Future<void> getLanguage() async {
    final val = await storage.readValue(languageCodeKey);
    _appLocale = Locale(val ?? 'en');
    customPrint('Entered to check Language: ${_appLocale?.languageCode}');
    emit(Locale(val ?? 'en'));
  }

  void changeLanguage(final Locale type) async {
    _appLocale = type;
    if (type == const Locale('en')) {
      await storage.saveValue(key: languageCodeKey, value: 'en');
      emit(const Locale('en'));
    } else if (type == const Locale('hi')) {
      await storage.saveValue(key: languageCodeKey, value: 'hi');
      emit(const Locale('hi'));
    } else {
      await storage.saveValue(key: languageCodeKey, value: 'mr');
      emit(const Locale('mr'));
    }
    customPrint('App Language Changed: ${_appLocale?.languageCode}');
  }
}
