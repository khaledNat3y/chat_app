import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/helper/shared_preferences.dart';

part 'settings_state.dart';
@injectable
class SettingsCubit extends Cubit<Locale> {
  SettingsCubit() : super(const Locale('en')) { 
    _loadLocale();
  }
  void _loadLocale() async {
    // Retrieve saved locale from SharedPreferences
    String? savedLanguageCode = await SharedPreferencesHelper.getData(key: 'language');
    if (savedLanguageCode != null) {
      emit(Locale(savedLanguageCode));
    }
  }
  void changeLocale(String languageCode) async{
    emit(Locale(languageCode));
    await SharedPreferencesHelper.setData(key: 'language', value: languageCode);
  }
}